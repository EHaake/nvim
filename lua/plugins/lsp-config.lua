-- lsp-config.lua
--
-- Language servers. Originally adapted from kickstart.nvim, rewritten for the
-- Neovim 0.11 `vim.lsp.config` / `vim.lsp.enable` API and mason-lspconfig v2.
--
-- How the pieces fit together:
--   nvim-lspconfig         ships a default config for each server in its lsp/ dir
--   vim.lsp.config(...)    merges our overrides (capabilities, settings) on top
--   mason.nvim             installs server binaries into ~/.local/share/nvim/mason
--   mason-tool-installer   makes sure the servers/formatters listed below exist
--   mason-lspconfig        calls vim.lsp.enable() for every server Mason has
--                          installed (automatic_enable), so anything installed
--                          via :Mason is picked up without listing it here
--   fidget.nvim            shows LSP progress in the bottom right
--
-- Rust is NOT handled here: rustaceanvim (lua/plugins/rust-stuff.lua) manages
-- rust-analyzer itself. Don't install rust-analyzer through Mason or you get
-- two clients and duplicate diagnostics.
--
-- Loaded when a file is opened, or when :Mason / :LspInfo is run.

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Mason", "LspInfo" },
		dependencies = {
			-- PATH = "skip": the Mason bin directory is put on PATH in lua/settings.lua.
			{ "mason-org/mason.nvim", opts = { PATH = "skip" } },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			-- Extra client capabilities (snippets, etc.) that blink.cmp understands.
			"saghen/blink.cmp",
		},
		config = function()
			-- [[ Per-buffer keymaps ]]
			-- Runs every time a server attaches to a buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("erik-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					local tb = function(picker)
						return function()
							require("telescope.builtin")[picker]()
						end
					end

					map("gd", tb("lsp_definitions"), "Goto definition")
					map("gr", tb("lsp_references"), "Goto references")
					map("gI", tb("lsp_implementations"), "Goto implementation")
					map("gtd", tb("lsp_type_definitions"), "Goto type definition")
					map("gD", vim.lsp.buf.declaration, "Goto declaration")
					map("<leader>fds", tb("lsp_document_symbols"), "Find document symbols")
					map("<leader>fws", tb("lsp_dynamic_workspace_symbols"), "Find workspace symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
					map("K", vim.lsp.buf.hover, "Hover documentation")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client then
						return
					end

					-- Highlight other references of the symbol under the cursor after
					-- the cursor rests (`:help CursorHold`), clear on move.
					if client:supports_method("textDocument/documentHighlight", event.buf) then
						local hl_group = vim.api.nvim_create_augroup("erik-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = hl_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = hl_group,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("erik-lsp-detach", { clear = true }),
							callback = function(ev)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "erik-lsp-highlight", buffer = ev.buf })
							end,
						})
					end

					if client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>uh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")
					end
				end,
			})

			-- [[ Capabilities ]]
			-- Tell every server what the client (Neovim + blink.cmp) supports.
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- [[ Servers ]]
			-- Keys are nvim-lspconfig server names (`:help lspconfig-all`). The value
			-- is merged over nvim-lspconfig's defaults; use an empty table to just
			-- install the server. Available keys: cmd, filetypes, capabilities,
			-- settings, root_markers.
			local servers = {
				clangd = {},
				gopls = {},
				pyright = {},
				ruff = {}, -- linting, import sorting, formatting (used by conform too)
				ts_ls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Make lua_ls aware of the Neovim runtime and every plugin
								-- so `vim.*` and plugin modules resolve in this config.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							completion = { callSnippet = "Replace" },
						},
					},
				},
			}
			for name, cfg in pairs(servers) do
				if next(cfg) ~= nil then
					vim.lsp.config(name, cfg)
				end
			end

			-- [[ Install ]]
			-- Servers above, the formatters conform.nvim uses (lua/plugins/conform.lua),
			-- and codelldb, the debug adapter rustaceanvim uses for Rust.
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua", "prettierd", "codelldb" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Enable every Mason-installed server. rust_analyzer is excluded in
			-- case it ever gets installed by accident (see header); stylua is
			-- excluded because its LSP mode only offers formatting, which
			-- conform.nvim already does with the stylua binary.
			require("mason-lspconfig").setup({
				automatic_enable = { exclude = { "rust_analyzer", "stylua" } },
			})
		end,
	},
}

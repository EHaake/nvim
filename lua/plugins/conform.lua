-- conform.lua
--
-- Formatting. conform.nvim runs an external formatter per filetype and falls
-- back to the LSP server's formatter when no entry exists for the filetype.
-- Formatter binaries come from Mason (listed in lua/plugins/lsp-config.lua
-- under ensure_installed) or the language toolchain (rustfmt via rustup).
--
-- Format on save is ON by default and can be toggled:
--   <leader>uf   toggle for this session (global)
--   <leader>uF   toggle for the current buffer only
-- To start Neovim with it off, set `vim.g.autoformat = false` in settings.lua.
-- <leader>bf formats explicitly regardless of the toggle.

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- needed so format_on_save can run on the first save
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>bf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "x" },
				desc = "Format buffer",
			},
			{
				"<leader>uf",
				function()
					vim.g.autoformat = not vim.g.autoformat
					vim.notify("Format on save: " .. (vim.g.autoformat and "on" or "off"))
				end,
				desc = "Toggle format on save (global)",
			},
			{
				"<leader>uF",
				function()
					vim.b.autoformat = not (vim.b.autoformat ~= false)
					vim.notify("Format on save (buffer): " .. (vim.b.autoformat and "on" or "off"))
				end,
				desc = "Toggle format on save (buffer)",
			},
		},
		init = function()
			if vim.g.autoformat == nil then
				vim.g.autoformat = true
			end
		end,
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				if not vim.g.autoformat or vim.b[bufnr].autoformat == false then
					return
				end
				return { timeout_ms = 1000, lsp_format = "fallback" }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- ruff handles both import sorting and formatting (replaces isort + black).
				python = { "ruff_organize_imports", "ruff_format" },
				rust = { "rustfmt" },
				go = { "gofmt" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				markdown = { "prettierd" },
				yaml = { "prettierd" },
			},
		},
	},
}

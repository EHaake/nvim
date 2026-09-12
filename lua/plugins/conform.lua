-- conform.lua
--
-- Formatting. conform.nvim runs an external formatter per filetype and falls
-- back to the LSP server's formatter when no entry exists for the filetype.
-- The formatter binaries come from Mason (listed in lua/plugins/lsp-config.lua
-- under ensure_installed) or from the language toolchain (rustfmt via rustup).
--
-- Format-on-save is intentionally off; format explicitly with <leader>bf.
-- Loaded on demand by that keymap or :ConformInfo.

return {
	{
		"stevearc/conform.nvim",
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
		},
		opts = {
			notify_on_error = true,
			-- format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" }, -- run in order
				rust = { "rustfmt" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				-- Run the first available of several: { "prettierd", "prettier", stop_after_first = true }
			},
		},
	},
}

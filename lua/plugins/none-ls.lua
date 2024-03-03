return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Formatting
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.rustywind,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.isort,
				-- Diagnostics
			},
		})
		vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "format buffer" })
	end,
}

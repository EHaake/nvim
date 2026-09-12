-- fterm.lua
--
-- Floating terminal toggled with <F9> from normal or terminal mode.
-- https://github.com/numtostr/FTerm.nvim  (`:help FTerm.nvim-configuration`)

return {
	"numToStr/FTerm.nvim",
	keys = {
		{
			"<F9>",
			function()
				require("FTerm").toggle()
			end,
			desc = "Toggle floating terminal",
		},
		{ "<F9>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<CR>", mode = "t", desc = "Toggle floating terminal" },
	},
	opts = {
		border = "double",
		dimensions = { height = 0.8, width = 0.7 },
	},
}

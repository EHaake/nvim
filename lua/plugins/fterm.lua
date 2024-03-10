return {
	"numToStr/FTerm.nvim",

	config = function()
		local config = require("FTerm")
		config.setup({
			border = "double",
			dimensions = {
				height = 0.8,
				width = 0.7,
			},
		})
	end,

	-- toggle in normal mode
	vim.keymap.set("n", "<F9>", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle FTerm" }),
	-- toggle in terminal mode
	vim.keymap.set(
		"t",
		"<F9>",
		'<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
		{ desc = "Toggle FTerm terminal mode" }
	),
}

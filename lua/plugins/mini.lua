-- mini.lua
--
-- mini.nvim is a collection of small independent modules; only the ones set
-- up below are active. https://github.com/echasnovski/mini.nvim
--
--   mini.ai  extra text objects, e.g.
--              va)   select around parens
--              yinq  yank inside next quote
--              ci'   change inside quotes
--
-- Surround editing is handled by nvim-surround (lua/plugins/surround.lua), so
-- mini.surround is not enabled here.

return {
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
		end,
	},
}

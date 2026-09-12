-- snacks.lua
--
-- folke/snacks.nvim is a bundle of small QoL modules; every module is off
-- unless enabled here. Enabled:
--   input     floating window for vim.ui.input (LSP rename etc.); replaces
--             the archived dressing.nvim
--   bigfile   turns off treesitter/LSP/etc. in very large files so they open
--             instantly
--
-- vim.ui.select is still handled by telescope-ui-select (lua/plugins/telescope.lua).

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		input = { enabled = true },
		bigfile = { enabled = true },
	},
}

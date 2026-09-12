-- themes.lua
--
-- Colorschemes. nordic is the active one; the rest are installed so they show
-- up in `:Telescope colorscheme` (with live preview) and can be tried with
-- `:colorscheme <name>`. Themes have to be on the runtimepath to appear there,
-- which is why they aren't lazy-loaded; they cost almost nothing at startup.
--
-- catppuccin is also used for its palette by lua/plugins/wilder.lua.
--
-- To switch permanently: move `priority = 1000` and the `config` that calls
-- the colorscheme onto the theme you want.

return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000, -- load before every other plugin so highlights are ready
		config = function()
			require("nordic").load()
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "rmehri01/onenord.nvim", name = "onenord" },
	{ "rebelot/kanagawa.nvim", name = "kanagawa" },
	{ "folke/tokyonight.nvim", opts = {} },
}

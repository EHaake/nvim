return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"rmehri01/onenord.nvim",
		name = "onenord",
		priority = 1001,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require 'nordic' .load()
    end
	},
}

-- harpoon.lua
--
-- Pin a handful of files and jump between them by number (harpoon v2, the
-- `harpoon2` branch). Marks are stored per project (cwd). The current mark
-- index is shown in lualine (lua/plugins/lualine.lua).
--
--   <leader>ha   add current file        <leader>ho   open the mark list
--   <leader>hr   remove current file     <leader>hc   clear all marks
--   <leader>h1-5 jump to mark N

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>ha",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file",
		},
		{
			"<leader>hr",
			function()
				require("harpoon"):list():remove()
			end,
			desc = "Remove file",
		},
		{
			"<leader>hc",
			function()
				require("harpoon"):list():clear()
			end,
			desc = "Clear all files",
		},
		{
			"<leader>ho",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle quick menu",
		},
		{
			"<leader>h1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Go to file 1",
		},
		{
			"<leader>h2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Go to file 2",
		},
		{
			"<leader>h3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Go to file 3",
		},
		{
			"<leader>h4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Go to file 4",
		},
		{
			"<leader>h5",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "Go to file 5",
		},
	},
	config = function()
		-- harpoon2's setup is a method (colon call), so lazy's `opts` shortcut
		-- can't be used here.
		require("harpoon"):setup({})
	end,
}

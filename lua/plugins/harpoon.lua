return {
	"ThePrimeagen/harpoon",
	lazy = false,
	config = function(_, opts)
		require("harpoon").setup(opts)
		require("telescope").load_extension("harpoon")
		local harpoon_ui = require("harpoon.ui")
		local harpoon_mark = require("harpoon.mark")

		-- Set keymaps
		vim.keymap.set("n", "<leader>ho", harpoon_ui.toggle_quick_menu, { desc = "Toggle quick menu" })
		vim.keymap.set("n", "<leader>ha", harpoon_mark.add_file, { desc = "Add file" })
		vim.keymap.set("n", "<leader>hr", harpoon_mark.rm_file, { desc = "Remove file" })
		vim.keymap.set("n", "<leader>hc", harpoon_mark.clear_all, { desc = "Clear all files" })

		vim.keymap.set("n", "<leader>h1", function() harpoon_ui.nav_file(1) end, { desc = "Nav to file 1" })
		vim.keymap.set("n", "<leader>h2", function() harpoon_ui.nav_file(2) end, { desc = "Nav to file 2" })
		vim.keymap.set("n", "<leader>h3", function() harpoon_ui.nav_file(3) end, { desc = "Nav to file 3" })
		vim.keymap.set("n", "<leader>h4", function() harpoon_ui.nav_file(4) end, { desc = "Nav to file 4" })
		vim.keymap.set("n", "<leader>h5", function() harpoon_ui.nav_file(5) end, { desc = "Nav to file 5" })
	end,
}

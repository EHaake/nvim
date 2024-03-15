return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			under_cursor = false,
			filetypes_denylist = {
				"TelescopePrompt",
				"alpha",
				"harpoon",
				"neo-tree",
			},
		})

		local illuminate = require("illuminate")
		vim.keymap.set("n", "<leader>]", illuminate.goto_next_reference, { desc = "illuminate goto next reference" })
		vim.keymap.set("n", "<leader>[", illuminate.goto_prev_reference, { desc = "illuminate goto prev reference" })
	end,
}

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-\\>", ":Neotree toggle <CR>", { desc = "toggle neotree files" })
		vim.keymap.set(
			"n",
			"<leader>gs",
			":Neotree toggle show git_status <CR>",
			{ desc = "toggle neotree git status" }
		)
	end,
}

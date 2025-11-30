return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	-- default options go here
	opts = {
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = "open_default",
		},
	},

	config = function(_, opts)
		vim.keymap.set("n", "<C-\\>", ":Neotree toggle <CR>", { desc = "toggle neotree files" })
		vim.keymap.set(
			"n",
			"<leader>gs",
			":Neotree toggle show git_status <CR>",
			{ desc = "toggle neotree git status" }
		)
		require("neo-tree").setup(opts)
	end,
}

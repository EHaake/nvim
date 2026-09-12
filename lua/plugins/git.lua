-- git.lua
--
-- gitsigns   change markers in the gutter, hunk preview, inline blame
-- lazygit    opens the lazygit TUI in a floating window (needs `lazygit` on PATH)
--
-- Neo-tree's git status view is mapped to <leader>gs in lua/plugins/neotree.lua.

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- signs = { add = { text = "+" }, change = { text = "~" }, delete = { text = "_" } },
		},
		keys = {
			{ "<leader>gph", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
			{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
		},
	},
}

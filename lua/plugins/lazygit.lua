return {
	"kdheepak/lazygit.nvim",
	config = function()
		require("telescope").load_extension("lazygit")

		vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>" , {desc = "LazyGit"})
	end,
}

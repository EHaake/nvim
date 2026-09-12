-- neotree.lua
--
-- File tree sidebar. <C-\> toggles it; <leader>gs shows the git status view.
-- Also opens when Neovim is started on a directory (`nvim .`).

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<C-\\>", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
		{ "<leader>gs", "<cmd>Neotree toggle show git_status<CR>", desc = "Toggle git status tree" },
	},
	init = function()
		-- The plugin is lazy-loaded, so hijacking netrw for `nvim <dir>` needs a
		-- nudge: load it eagerly when the only argument is a directory.
		if vim.fn.argc(-1) == 1 then
			local stat = vim.uv.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				require("neo-tree")
			end
		end
	end,
	opts = {
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = "open_default",
		},
	},
}

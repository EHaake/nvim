-- See `:help gitsigns` to understand what the configuration keys do
return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		--
		-- NOTE: example of how to set different icons for changes
		--
		-- opts = {
		-- 	signs = {
		-- 		add = { text = "+" },
		-- 		change = { text = "~" },
		-- 		delete = { text = "_" },
		-- 		topdelete = { text = "‾" },
		-- 		changedelete = { text = "~" },
		-- 	},
		-- },
		config = function(_, opts)
			require("gitsigns").setup(opts)
			-- keymaps
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "gitsigns preview hunk" })
			vim.keymap.set(
				"n",
				"<leader>gb",
				":Gitsigns toggle_current_line_blame<cr>",
				{ desc = "gitsigns toggle line blame" }
			)
		end,
	},
}

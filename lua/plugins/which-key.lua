-- which-key.lua
--
-- Pops up the available keymaps after a prefix is pressed. Descriptions come
-- from the `desc` field on each keymap; the entries below only name the
-- <leader> groups so the popup shows e.g. "+find" instead of "+prefix".
--
-- Add a group here whenever a new <leader>x prefix is introduced.

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>d", group = "debug" },
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "harpoon" },
				{ "<leader>m", group = "markdown" },
				{ "<leader>r", group = "rename" },
				{ "<leader>s", group = "save" },
				{ "<leader>t", group = "test" },
				{ "<leader>u", group = "ui" },
				{ "<leader>ud", group = "diagnostics" },
				{ "<leader>udl", group = "level" },
				{ "<leader>udr", group = "rust sources" },
				{ "<leader>ue", group = "echo" },
			},
		},
	},
}

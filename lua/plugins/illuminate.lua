-- illuminate.lua
--
-- Highlights other occurrences of the word under the cursor, using LSP or
-- treesitter when available and a plain regex otherwise.
-- <leader>] / <leader>[ jump between the highlighted references.

return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<leader>]",
			function()
				require("illuminate").goto_next_reference()
			end,
			desc = "Next reference",
		},
		{
			"<leader>[",
			function()
				require("illuminate").goto_prev_reference()
			end,
			desc = "Previous reference",
		},
	},
	config = function()
		require("illuminate").configure({
			under_cursor = false,
			filetypes_denylist = { "TelescopePrompt", "alpha", "harpoon", "neo-tree" },
		})
	end,
}

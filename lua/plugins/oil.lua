-- oil.lua
--
-- Edit a directory like a buffer: rename, move, and delete files by editing
-- text, then :w. <leader>- opens the parent directory of the current file.
-- Adapted from https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/plugins/oil.lua
--
-- Keys inside an oil buffer (g? shows this list):
--   <CR> open        -  parent dir     _  open cwd      `  :cd here
--   <C-\> split      <C-Enter> vsplit  <C-t> tab        <C-p> preview
--   <C-c> close      <C-r> refresh     gs sort          g. toggle hidden

return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>-", "<cmd>Oil<CR>", desc = "Open parent directory (oil)" },
	},
	opts = {
		-- neo-tree handles `nvim <dir>`; keep oil to its explicit keymap.
		default_file_explorer = false,
		use_default_keymaps = false,
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-\\>"] = "actions.select_split",
			["<C-enter>"] = "actions.select_vsplit",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-r>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
		},
		view_options = { show_hidden = true },
	},
}

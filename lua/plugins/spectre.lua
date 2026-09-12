-- spectre.lua
--
-- Project-wide search and replace with a preview panel (uses ripgrep).
-- Adapted from https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/plugins/spectre.lua

return {
	"nvim-pack/nvim-spectre",
	cmd = "Spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>S", "<cmd>Spectre<CR>", desc = "Search and replace (Spectre)" },
	},
	opts = {
		mapping = {
			["send_to_qf"] = {
				map = "<C-q>",
				cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
				desc = "send all items to quickfix",
			},
		},
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local harpoon = require("harpoon.mark")

		-- Thanks to Dillon Mulroy for this snippet
		-- https://www.youtube.com/watch?v=oo_I5lAmdi0&t=1280s
		-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/plugins/lualine.lua
		local function harpoon_component()
			local total_marks = harpoon.get_length()

			if total_marks == 0 then
				return ""
			end

			local current_mark = "—"

			local mark_idx = harpoon.get_current_index()
			if mark_idx ~= nil then
				current_mark = tostring(mark_idx)
			end

			return string.format("󱡅 %s/%d", current_mark, total_marks)
		end

		require("lualine").setup({
			options = {
				-- theme = 'tokyonight'
				theme = "dracula",
			},
			sections = {
				lualine_b = {
					{ "branch", icon = "" },
					harpoon_component,
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = {
					"filetype",
				},
			},
		})
	end,
}

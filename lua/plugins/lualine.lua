-- lualine.lua
--
-- Status line. Sections (left to right):
--   mode | branch, harpoon mark, diff, diagnostics | relative filename | filetype | progress | location
--
-- Loaded on VeryLazy (right after startup) so it doesn't slow the first paint.

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Shows "󱡅 2/4" = current file is harpoon mark 2 of 4. Empty when there
		-- are no marks. Doesn't force harpoon to load; it only reports once
		-- harpoon has been used in this session.
		-- Thanks to Dillon Mulroy: https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/plugins/lualine.lua
		local function harpoon_component()
			if not package.loaded["harpoon"] then
				return ""
			end
			local list = require("harpoon"):list()
			local total = list:length()
			if total == 0 then
				return ""
			end
			-- harpoon2 stores paths relative to the project root (cwd).
			local current = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
			local idx
			for i = 1, total do
				local item = list.items[i] -- can have holes after removals
				if item and item.value == current then
					idx = i
					break
				end
			end
			return string.format("󱡅 %s/%d", idx and tostring(idx) or "—", total)
		end

		require("lualine").setup({
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_b = {
					{ "branch", icon = "" },
					harpoon_component,
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{ "filename", path = 1 }, -- path relative to cwd
				},
				lualine_x = { "filetype" },
			},
		})
	end,
}

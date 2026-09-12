-- telescope.lua
--
-- Fuzzy finder for files, text, buffers, help, LSP symbols, and more.
-- Adapted from kickstart.nvim. Loaded on the first keymap below or :Telescope.
--
-- Inside a picker: <C-/> (insert mode) or ? (normal mode) lists the picker's
-- own keymaps. `:Telescope builtin` (<leader>ft) lists every picker.
--
-- LSP pickers (gd, gr, <leader>fds, ...) are mapped per buffer in
-- lua/plugins/lsp-config.lua.

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				-- Native fzf sorter: faster and supports fzf syntax (^, $, !, ').
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			-- Routes vim.ui.select (code actions, etc.) through a Telescope dropdown.
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find by grep" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help" },
			{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
			{ "<leader>ft", "<cmd>Telescope builtin<CR>", desc = "Find Telescope pickers" },
			{ "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Find current word" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Find diagnostics" },
			{ "<leader>fr", "<cmd>Telescope resume<CR>", desc = "Resume last picker" },
			{ "<leader>f.", "<cmd>Telescope oldfiles<CR>", desc = "Find recent files" },
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(
						require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
					)
				end,
				desc = "Fuzzy search current buffer",
			},
			{
				"<leader>f/",
				function()
					require("telescope.builtin").live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end,
				desc = "Find in open files",
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find config files",
			},
		},
		config = function()
			local telescope = require("telescope")
			-- See `:help telescope.setup()` for defaults, mappings, and per-picker options.
			telescope.setup({
				pickers = {
					colorscheme = { enable_preview = true },
				},
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown() },
				},
			})
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
		end,
	},
}

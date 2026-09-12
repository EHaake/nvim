-- git.lua
--
-- gitsigns   change markers in the gutter, hunk navigation/staging, blame
-- lazygit    opens the lazygit TUI in a floating window (needs `lazygit` on PATH)
--
-- Neo-tree's git status view is mapped to <leader>gs in lua/plugins/neotree.lua.
--
--   ]h / [h        next / previous hunk        <leader>ghp  preview hunk
--   <leader>ghs    stage/unstage hunk (n: cursor, v: selection)
--   <leader>ghr    reset hunk                   <leader>ghi  preview hunk inline
--   <leader>ghS    stage whole buffer           <leader>ghR  reset whole buffer
--   <leader>ghb    blame current line (full)    <leader>gb   toggle inline blame
--   <leader>ghd    diff against index           <leader>gg   LazyGit

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- signs = { add = { text = "+" }, change = { text = "~" }, delete = { text = "_" } },
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local map = function(mode, keys, func, desc)
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
				end

				-- Navigation (falls back to the diff-mode ]c / [c inside :diffthis).
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Previous hunk")

				-- Hunk actions
				map("n", "<leader>ghs", gs.stage_hunk, "Stage/unstage hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage selection")
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset selection")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>ghi", gs.preview_hunk_inline, "Preview hunk inline")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>ghd", gs.diffthis, "Diff against index")
				map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle inline blame")

				-- Text object: `ih` selects the hunk under the cursor.
				map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
			end,
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
		},
	},
}

-- keymaps.lua
--
-- Global keymaps that don't belong to any one plugin. Plugin keymaps are
-- defined next to the plugin in lua/plugins/<name>.lua (usually in a `keys`
-- table so the mapping also triggers lazy loading).
--
-- Leader is <Space> (set in lua/settings.lua). Leader prefixes are grouped
-- and labelled for which-key in lua/plugins/which-key.lua:
--
--   <leader>b   buffer        <leader>h   harpoon
--   <leader>gh  git hunks     <leader>s   save / session
--   <leader>c   code (LSP)    <leader>m   markdown
--   <leader>d   debug         <leader>s   save
--   <leader>f   find          <leader>t   test
--   <leader>g   git           <leader>u   ui toggles (diagnostics under <leader>ud)
--
-- `:Telescope keymaps` (<leader>fk) lists every mapping with its description.

local map = vim.keymap.set

-- [[ Insert mode ]]
-- Emacs-style cursor movement without leaving insert mode.
map("i", "<C-f>", "<Right>", { desc = "Move cursor right" })
map("i", "<C-b>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-n>", "<Down>", { desc = "Move cursor down" })
map("i", "<C-p>", "<Up>", { desc = "Move cursor up" })
map("i", "<C-e>", "<End>", { desc = "Move cursor to end of line" })
map("i", "<C-a>", "<Home>", { desc = "Move cursor to start of line" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- [[ Normal mode ]]
map("n", "H", "^", { desc = "First non-blank character of line" })
map("n", "L", "$", { desc = "End of line" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation: Ctrl+hjkl instead of Ctrl+w then hjkl. See `:help wincmd`.
map("n", "<C-h>", "<C-w><C-h>", { desc = "Focus window left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Focus window right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Focus window below" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Focus window above" })

-- [[ Visual mode ]]
-- Keep the selection after indenting so `>` / `<` can be repeated.
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- [[ Terminal mode ]]
-- <Esc><Esc> leaves terminal mode. Some terminal emulators / tmux setups eat
-- this; the built-in fallback is <C-\><C-n>.
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Files and buffers ]]
map("n", "<leader>sf", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>sa", "<cmd>wa<CR>", { desc = "Save all files" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bc", "<cmd>close<CR>", { desc = "Close window" })
-- <leader>bd (delete buffer, keep window layout) lives in lua/plugins/snacks.lua.

-- [[ Diagnostics ]]
-- Neovim 0.11 maps [d / ]d to vim.diagnostic.jump by default; these override
-- them only so the float opens after the jump.
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<leader>q", "<cmd>ToggleQFList<CR>", { desc = "Toggle diagnostic quickfix list" })

-- Toggle a floating window with the diagnostics under the cursor. If any
-- floating window is already open (e.g. a hover), close it instead.
map("n", "<leader>e", function()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, false)
			return
		end
	end
	vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Toggle diagnostic float" })

-- Echo the first diagnostic on the current line in the command area. Handy
-- when inline text is turned off.
map("n", "<leader>uep", function()
	local diags = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diags == 0 then
		vim.api.nvim_echo({ { "No diagnostics on this line", "Comment" } }, false, {})
		return
	end
	vim.api.nvim_echo({ { (diags[1].message:gsub("\n.*", "")), "WarningMsg" } }, false, {})
end, { desc = "Echo diagnostic on line" })

-- [[ UI toggles: <leader>u ]]
local diag = require("diagnostics")

map("n", "<leader>uc", function()
	vim.wo.colorcolumn = vim.wo.colorcolumn == "" and "80" or ""
end, { desc = "Toggle 80-column guide" })

-- Diagnostics presentation (<leader>ud...). Implemented in lua/diagnostics.lua.
map("n", "<leader>udt", diag.toggle, { desc = "Toggle diagnostics on/off" })
map("n", "<leader>udi", diag.toggle_virtual_text, { desc = "Toggle inline text" })
map("n", "<leader>udg", diag.toggle_signs, { desc = "Toggle gutter signs" })
map("n", "<leader>udq", diag.mode_quiet, { desc = "Quiet mode (no inline, no signs)" })
map("n", "<leader>udf", diag.mode_full, { desc = "Full mode (everything on)" })

-- Severity floor (<leader>udl...)
map("n", "<leader>udlc", diag.cycle_severity, { desc = "Cycle (E -> W+E -> ALL)" })
map("n", "<leader>udle", diag.only_errors, { desc = "ERROR only" })
map("n", "<leader>udlw", diag.warn_and_error, { desc = "WARN + ERROR" })
map("n", "<leader>udla", diag.all_severities, { desc = "ALL severities" })

-- Rust-only source filters (<leader>udr...), attached per Rust buffer.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("rust-diagnostic-keymaps", { clear = true }),
	pattern = "rust",
	desc = "Rust-only diagnostic source filter keymaps",
	callback = function(args)
		map("n", "<leader>udra", diag.only_rust_analyzer, { buffer = args.buf, desc = "rust-analyzer only" })
		map("n", "<leader>udrc", diag.allow_rustc, { buffer = args.buf, desc = "rust-analyzer + rustc" })
	end,
})

-- Dump LSP client state plus the message history for debugging a misbehaving server.
map("n", "<leader>uI", function()
	vim.cmd("checkhealth vim.lsp")
end, { desc = "Inspect LSP clients" })

-- keymaps.lua
--
-- This is where all global Neovim keymaps go, plugin specific keymaps will
-- go in their respective plugin files.
--
-- Map leader to Space
vim.g.mapleader = " "

-- Enable emacs cursor commands in insert mode
vim.keymap.set("i", "<C-f>", "<right>", { desc = "Move cursor right in insert mode" })
vim.keymap.set("i", "<C-b>", "<left>", { desc = "Move cursor left in insert mode" })
vim.keymap.set("i", "<C-n>", "<down>", { desc = "Move cursor down in insert mode" })
vim.keymap.set("i", "<C-p>", "<up>", { desc = "Move cursor up in insert mode" })
vim.keymap.set("i", "<C-e>", "<end>", { desc = "Move cursor to end of line in insert mode" })
vim.keymap.set("i", "<C-a>", "<home>", { desc = "Move cursor to beginning of line in insert mode" })

-- Navigate beginning/end of line
vim.keymap.set("n", "H", "^", {})
vim.keymap.set("n", "L", "$", {})

-- Escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with 'jk'" })

-- save files
vim.keymap.set("n", "<leader>sf", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sa", "<cmd>wa<cr>", { desc = "Save all files " })

-- Buffers
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>", { desc = "go to previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>", { desc = "go to next buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>close<cr>", { desc = "close buffer" })

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlight " })

--
-- Diagnostic navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
vim.keymap.set("n", "<leader>q", "<cmd>ToggleQFList<cr>", { desc = "Toggle diagnostic [q]uickfix list" })
-- Diagnostic Popup toggle
vim.keymap.set("n", "<leader>e", function()
  -- Check if a floating window already exists
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      vim.api.nvim_win_close(win, false)
      return
    end
  end

  -- Otherwise, open diagnostic float
  vim.diagnostic.open_float(nil, {
    focus = false,
    scope = "cursor",
    border = "rounded",
  })
end, { desc = "Toggle line diagnostics popup" })

--
-- UI → Diagnostics toggles (global)
local diag = require("diagnostics")

-- Toggle inline diagnostics (virtual text)
vim.keymap.set("n", "<leader>udi", function()
  diag.toggle_virtual_text()
end, { desc = "Diagnostics → toggle inline text" })

-- Toggle diagnostic signs (gutter)
vim.keymap.set("n", "<leader>udg", function()
  diag.toggle_signs()
end, { desc = "Diagnostics → toggle gutter signs" })

-- Preset modes
vim.keymap.set("n", "<leader>udq", function()
  diag.mode_quiet()
end, { desc = "Diagnostics → quiet mode (no inline, no signs)" })

vim.keymap.set("n", "<leader>udf", function()
  diag.mode_full()
end, { desc = "Diagnostics → full mode" })

--
-- UI → Diagnostics toggles (Rust-only bindings)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(args)
    local buf = args.buf

    -- Source filters: RA only vs RA + rustc
    vim.keymap.set("n", "<leader>udra", function()
      diag.only_rust_analyzer()
    end, { buffer = buf, desc = "rust-analyzer only inline" })

    vim.keymap.set("n", "<leader>udrc", function()
      diag.allow_rustc()
    end, { buffer = buf, desc = "rust-analyzer + rustc inline" })
  end,
})

vim.keymap.set("n", "<leader>uep", function()
  local diags = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diags == 0 then
    vim.api.nvim_echo({ { "No diagnostics on this line", "Comment" } }, false, {})
    return
  end

  local msg = diags[1].message:gsub("\n.*", "")
  vim.api.nvim_echo({ { msg, "WarningMsg" } }, false, {})
end, { desc = "echo diagnostics (peek)" })

-- Cycle severity: ERROR → WARN+ERROR → ALL
vim.keymap.set("n", "<leader>udlc", function()
  diag.cycle_severity()
end, { desc = "Level → cycle (E → W+E → ALL)" })

-- Set severity directly
vim.keymap.set("n", "<leader>udle", function()
  diag.only_errors()
end, { desc = "Level → ERROR only" })

vim.keymap.set("n", "<leader>udlw", function()
  diag.warn_and_error()
end, { desc = "Level → WARN + ERROR" })

vim.keymap.set("n", "<leader>udla", function()
  diag.all_severities()
end, { desc = "Level → ALL severities" })

vim.keymap.set("n", "<leader>uI", function()
  vim.cmd("LspInfo")
  vim.cmd("messages")
end, { desc = "Inspector (Dump all LSP + diagnostics)" })


-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window Navigation
-- Use CTRL+<hjkl> to switch between windows
--
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Visual code movment
vim.keymap.set("v", "<", "< gv")
vim.keymap.set("v", ">", "> gv")

-- UI Stuff
--
-- Toggle 80 width column
vim.keymap.set("n", "<leader>uc", function()
	if vim.wo.colorcolumn == "" then
		vim.wo.colorcolumn = "80"
	else
		vim.wo.colorcolumn = ""
	end
end, { desc = "Toggle ui column (80 columnwidth)" })

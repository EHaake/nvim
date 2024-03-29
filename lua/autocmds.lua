-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- From Dillon Mulroy's setup:
-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/vertical_help.lua
-- 
-- Open help windows in vertical split
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
	pattern = "help",
	desc = "Open help windows in vertical split",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})


-- From Dillon Mulroy's setup:
-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/edit_text.lua
-- 
-- Turn on spell checking and text wrapping for certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- From Dillon Mulroy's setup:
-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/toggle_diagnostics.lua
--
-- Toggle diagnostics
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	if vim.g.diagnostics_enabled == nil then
		vim.g.diagnostics_enabled = false
		vim.diagnostic.disable()
	elseif vim.g.diagnostics_enabled then
		vim.g.diagnostics_enabled = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_enabled = true
		vim.diagnostic.enable()
	end
end, {})


-- Toggles the Quick Fix list by setting and opening it if it doesn't exist,
-- and closing it otherwise.
vim.api.nvim_create_user_command("ToggleQFList", function()
  local qf_exists = false

	-- Get the current windows
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end

	-- If quickfix is one of the windows...
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end

	-- otherwise set the qflist and open it.
	if not qf_exists then
		vim.diagnostic.setqflist()
    vim.cmd "copen"
	end
end, {})

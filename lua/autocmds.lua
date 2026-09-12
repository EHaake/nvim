-- autocmds.lua
--
-- Autocommands and user commands that aren't tied to a plugin.
-- See `:help lua-guide-autocommands` and `:help nvim_create_user_command`.

local augroup = function(name)
	return vim.api.nvim_create_augroup("erik-" .. name, { clear = true })
end

-- Briefly highlight yanked text. Try it with `yap`.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight-yank"),
	desc = "Highlight when yanking text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Open :help in a vertical split on the right instead of a horizontal one.
-- From https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/vertical_help.lua
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("vertical-help"),
	pattern = "help",
	desc = "Open help windows in a vertical split",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})

-- Prose-like filetypes get soft wrap and spell checking.
-- From https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/edit_text.lua
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("edit-text"),
	pattern = { "gitcommit", "markdown", "text" },
	desc = "Enable wrap and spell for prose filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- :ToggleDiagnostics  turn diagnostics on/off globally (same as <leader>udt).
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	require("diagnostics").toggle()
end, { desc = "Toggle diagnostics on/off" })

-- :ToggleQFList  open the quickfix list filled with all diagnostics, or close
-- it if a quickfix window is already open. Mapped to <leader>q.
vim.api.nvim_create_user_command("ToggleQFList", function()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			vim.cmd("cclose")
			return
		end
	end
	vim.diagnostic.setqflist()
end, { desc = "Toggle the diagnostics quickfix list" })

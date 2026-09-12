-- sessions.lua
--
-- persistence.nvim saves a session (open buffers, windows, cwd) per project
-- directory automatically on exit. Nothing is restored unless you ask:
--   <leader>ss   restore the session for the current directory
--   <leader>sl   restore the last session, whatever directory it was
--   <leader>sd   stop recording, so quitting won't overwrite the saved session
-- The dashboard's "s" key also restores the current directory's session.

return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>ss",
			function()
				require("persistence").load()
			end,
			desc = "Restore session (cwd)",
		},
		{
			"<leader>sl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>sd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't save session on exit",
		},
	},
}

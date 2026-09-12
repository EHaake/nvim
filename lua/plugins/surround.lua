-- surround.lua
--
-- Add, change, and delete surrounding pairs:
--   ysiw)   surround word with ()       ds"   delete surrounding quotes
--   cs'"    change ' to "               yss)  surround whole line
-- `:help nvim-surround.usage` and `:help nvim-surround.configuration`.

return {
	"kylechui/nvim-surround",
	version = "^3.0.0",
	event = "VeryLazy",
	opts = {},
}

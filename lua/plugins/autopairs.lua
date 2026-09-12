-- autopairs.lua
--
-- Inserts the closing bracket/quote automatically while typing. Brackets
-- after accepting a function completion are added by blink.cmp itself
-- (completion.accept.auto_brackets), so no completion hook is needed here.

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {},
}

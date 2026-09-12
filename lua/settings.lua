-- settings.lua
--
-- Global Neovim options. Everything here is plain `vim.opt` / `vim.g`; nothing
-- depends on a plugin, so this file runs before lazy.nvim is set up.
-- See `:help option-list` for the full list of options.

-- Leader key. Must be set before lazy.nvim loads so that plugin `keys` specs
-- that use <leader> resolve to the right key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Remote-plugin providers ]]
--
-- Neovim can run plugins written in Python, Node, Ruby, and Perl through
-- "providers". None of the plugins in this config need them, but Neovim probes
-- for each provider lazily the first time something evaluates `has('python3')`
-- (or node/ruby/perl). On this machine those probes are slow because they spawn
-- the interpreter and look for the host package (pynvim, neovim npm module, ...):
--
--   python3 via the pyenv shim  ~0.85 s
--   node                        ~0.3 s
--   perl                        ~2.6 s
--
-- wilder.nvim evaluates `has('python3')` the first time you press `:`, which is
-- what made the first command line of every session hang for about a second.
-- Setting the loaded_*_provider flags to 0 tells Neovim to skip the probe and
-- report the provider as unavailable. `:checkhealth provider` will list them as
-- disabled, which is expected.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- [[ Mason tools on PATH ]]
-- Mason installs servers, formatters, and the tree-sitter CLI into this bin
-- directory. Putting it on PATH here (rather than letting mason.nvim do it when
-- it loads) means nvim-treesitter can compile parsers and conform can find
-- formatters even before an LSP has been started.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(mason_bin, 1, true) then
	vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- [[ Neovide ]]
if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono:h13"
	vim.g.neovide_scale_factor = 1.4
end

-- [[ Indentation ]]
-- Display width of a tab and how much `>>` / `<<` shift. Tabs are kept as tabs
-- (no expandtab); individual filetypes can override this via ftplugins.
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.breakindent = true -- wrapped lines keep their indent

-- [[ UI ]]
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8 -- keep 8 lines visible above/below the cursor
vim.opt.signcolumn = "yes:1" -- always reserve the gutter so text doesn't jump
vim.opt.showmode = false -- lualine already shows the mode
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse = "a"

-- Show invisible characters. Off by default; toggle with `:set list!`.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- [[ Search ]]
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- ...unless the pattern contains uppercase
vim.opt.inccommand = "split" -- live preview of :s substitutions

-- [[ Files ]]
vim.opt.undofile = true -- persistent undo across sessions
vim.opt.clipboard = "unnamedplus" -- share the system clipboard

-- [[ Formatting ]]
-- Format on save (conform.nvim) is on by default; uncomment to start with it off.
-- Toggle at runtime with <leader>uf (global) or <leader>uF (buffer).
-- vim.g.autoformat = false

-- Diagnostics (virtual text, signs, severity filters) are configured in
-- lua/diagnostics.lua so the runtime toggles and the defaults live together.

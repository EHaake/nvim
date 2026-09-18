# Erik's Neovim config

A Lua config that turns Neovim into a working IDE for Rust, Go, Python,
TypeScript, C/C++, and Lua without dragging in a full distribution. Built on
[lazy.nvim](https://github.com/folke/lazy.nvim) for plugins and
[Mason](https://github.com/mason-org/mason.nvim) for language servers,
formatters, and debug adapters. Requires Neovim 0.11+.

Most of the LSP, completion, and Telescope setup started life in
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim); see
[Acknowledgements](#acknowledgements).

## Layout

```
init.lua                  entry point: load order + lazy.nvim setup
stylua.toml               formatting rules for the Lua in this repo
lua/
  lazy-bootstrap.lua      clones lazy.nvim on first run
  settings.lua            vim options, leader key, provider settings
  diagnostics.lua         vim.diagnostic presentation + runtime toggles
  keymaps.lua             global keymaps (not tied to a plugin)
  autocmds.lua            autocommands and user commands
  plugins/                one file per plugin (or per group), read by lazy.nvim
```

Every file in `lua/plugins/` returns a lazy.nvim plugin spec and starts with a
header comment explaining what the plugin does, when it loads, and which keys
it adds. Plugin keymaps live in the plugin's own file in a `keys = {}` table,
so pressing the key is also what loads the plugin.

Startup is deliberately light: only the colorschemes, treesitter, snacks.nvim,
and rustaceanvim load before the first buffer. Everything else waits for an event
(opening a file, entering insert mode), a command, or a keymap. `:Lazy profile`
shows what loaded and what it cost.

## Plugins

| Area       | Plugin                                                                                                                                                                                                                                                                                                                                                        | Loads on                       |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| Manager    | [lazy.nvim](https://github.com/folke/lazy.nvim)                                                                                                                                                                                                                                                                                                               | startup                        |
| LSP        | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [mason.nvim](https://github.com/mason-org/mason.nvim), [mason-lspconfig](https://github.com/mason-org/mason-lspconfig.nvim), [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim), [fidget.nvim](https://github.com/j-hui/fidget.nvim)                            | opening a file, `:Mason`       |
| Completion | [blink.cmp](https://github.com/saghen/blink.cmp), [LuaSnip](https://github.com/L3MON4D3/LuaSnip), [friendly-snippets](https://github.com/rafamadriz/friendly-snippets), [nvim-autopairs](https://github.com/windwp/nvim-autopairs), [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                                                              | insert mode                    |
| Formatting | [conform.nvim](https://github.com/stevearc/conform.nvim)                                                                                                                                                                                                                                                                                                      | saving a file, `<leader>bf`    |
| Syntax     | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`master`; `main` needs Neovim 0.12)                                                                                                                                                                                                                                                    | startup                        |
| Finding    | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (+ fzf-native, ui-select), [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)                                                                                                                                                                                                       | `<leader>f…`, `:Telescope`     |
| Files      | [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim), [oil.nvim](https://github.com/stevearc/oil.nvim), [harpoon](https://github.com/ThePrimeagen/harpoon) (v2)                                                                                                                                                                                         | keymaps, `nvim <dir>`          |
| Git        | [gitsigns](https://github.com/lewis6991/gitsigns.nvim), [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)                                                                                                                                                                                                                                              | opening a file, `<leader>gg`   |
| Sessions   | [persistence.nvim](https://github.com/folke/persistence.nvim)                                                                                                                                                                                                                                                                                                 | opening a file, `<leader>ss`   |
| Testing    | [neotest](https://github.com/nvim-neotest/neotest), [neotest-golang](https://github.com/fredrikaverpil/neotest-golang), [neotest-python](https://github.com/nvim-neotest/neotest-python), rustaceanvim adapter                                                                                                                                                | `<leader>t…`                   |
| Debugging  | [nvim-dap](https://github.com/mfussenegger/nvim-dap), [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui), [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim), [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)                                                                                                                         | `<F5>`, `<leader>db`           |
| Rust       | [rustaceanvim](https://github.com/mrcjkb/rustaceanvim), [crates.nvim](https://github.com/saecki/crates.nvim)                                                                                                                                                                                                                                                  | rust files, `Cargo.toml`       |
| Editing    | [Comment.nvim](https://github.com/numToStr/Comment.nvim), [nvim-surround](https://github.com/kylechui/nvim-surround), [mini.ai](https://github.com/echasnovski/mini.nvim), [todo-comments](https://github.com/folke/todo-comments.nvim)                                                                                                                       | after startup / opening a file |
| UI         | [snacks.nvim](https://github.com/folke/snacks.nvim) (dashboard, terminal, words, input, bufdelete, indent, bigfile), [lualine](https://github.com/nvim-lualine/lualine.nvim), [which-key](https://github.com/folke/which-key.nvim), [wilder.nvim](https://github.com/gelguy/wilder.nvim), [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) | startup / after startup / `:`  |
| Themes     | [nordic](https://github.com/AlexvZyl/nordic.nvim) (active), [catppuccin](https://github.com/catppuccin/nvim), [tokyonight](https://github.com/folke/tokyonight.nvim), [kanagawa](https://github.com/rebelot/kanagawa.nvim), [onenord](https://github.com/rmehri01/onenord.nvim)                                                                               | startup                        |

## Languages

| Language           | Server                                                         | Formatter               | Tests                | Debugger                          |
| ------------------ | -------------------------------------------------------------- | ----------------------- | -------------------- | --------------------------------- |
| Rust               | rust-analyzer via rustaceanvim (system install, **not** Mason) | rustfmt                 | cargo test / nextest | codelldb (Mason) via rustaceanvim |
| Go                 | gopls                                                          | gofmt                   | go test              | delve                             |
| Python             | pyright + ruff                                                 | ruff (imports + format) | pytest / unittest    | –                                 |
| TypeScript/JS      | ts_ls (+ eslint if installed)                                  | prettierd               | –                    | –                                 |
| JSON/YAML/Markdown | –                                                              | prettierd               | –                    | –                                 |
| C/C++              | clangd                                                         | LSP                     | –                    | –                                 |
| Lua                | lua_ls                                                         | stylua                  | –                    | –                                 |

Servers listed in `lua/plugins/lsp-config.lua` are installed automatically by
mason-tool-installer on the first file open. Anything else installed through
`:Mason` is enabled automatically too (mason-lspconfig's `automatic_enable`).

Format on save is on by default (conform.nvim, falling back to the LSP
formatter when no formatter is configured). `<leader>uf` toggles it for the
session, `<leader>uF` for the current buffer, and `vim.g.autoformat = false`
in `lua/settings.lua` starts with it off. `<leader>bf` always formats.

**To add a language:** add the server to the `servers` table in
`lua/plugins/lsp-config.lua` (an empty table is enough), add a formatter to
`formatters_by_ft` in `lua/plugins/conform.lua` and to the `ensure_installed`
list, and add the treesitter parser to `lua/plugins/treesitter.lua`.

## Keymaps

Leader is `<Space>`. Press it and wait for which-key, or run `<leader>fk` to
search every mapping with its description. The main groups:

| Prefix            | Group          | Examples                                                                                                                                                                       |
| ----------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<leader>f`       | find           | `ff` files, `fg` grep, `fb` buffers, `fh` help, `fk` keymaps, `f.` recent, `fc` this config                                                                                    |
| `<leader>g`       | git            | `gg` lazygit, `gs` status tree, `gb` toggle inline blame                                                                                                                       |
| `<leader>gh`      | git hunks      | `ghs` stage/unstage, `ghr` reset, `ghp` preview, `ghi` preview inline, `ghb` blame line, `ghd` diff, `ghS`/`ghR` whole buffer; `]h`/`[h` next/prev hunk, `ih` hunk text object |
| `<leader>h`       | harpoon        | `ha` add, `ho` menu, `h1`…`h5` jump                                                                                                                                            |
| `<leader>t`       | test           | `tt` nearest, `tf` file, `ta` all, `td` debug nearest, `ts` summary, `to` output                                                                                               |
| `<leader>d`       | debug          | `db` breakpoint, `dB` conditional breakpoint; `<F5>` continue, `<F1>`/`<F2>`/`<F3>` step, `<F7>` UI                                                                            |
| `<leader>u`       | ui             | `uf`/`uF` format on save (global/buffer), `uc` 80-col guide, `uh` inlay hints, `uI` LSP inspector                                                                              |
| `<leader>ud`      | diagnostics    | `udt` on/off, `udi` inline text, `udg` signs, `udq` quiet, `udf` full, `udl…` severity, `udr…` rust sources                                                                    |
| `<leader>b`       | buffer         | `bf` format, `bd` delete buffer (keeps layout), `bD` delete others, `bn`/`bp` next/prev, `bc` close window                                                                     |
| `<leader>s`       | save / session | `sf` save file, `sa` save all, `ss` restore session for cwd, `sl` restore last session, `sd` stop saving session                                                               |
| `<leader>c` / `r` | code           | `ca` code action, `rn` rename                                                                                                                                                  |

Other frequently used keys:

| Key                       | Action                                                       |
| ------------------------- | ------------------------------------------------------------ |
| `<leader><leader>`        | find files                                                   |
| `<leader>/`               | fuzzy search in current buffer                               |
| `<leader>e`               | toggle diagnostic float under cursor                         |
| `<leader>q`               | toggle diagnostics quickfix list                             |
| `[d` / `]d`               | previous / next diagnostic                                   |
| `gd` `gr` `gI` `gD` `K`   | LSP goto / references / implementation / declaration / hover |
| `<C-\>`                   | toggle neo-tree                                              |
| `<leader>-`               | open parent directory in oil                                 |
| `<leader>S`               | Spectre search & replace                                     |
| `<F9>`                    | floating terminal (normal and terminal mode)                 |
| `<leader>a`               | dashboard                                                    |
| `<leader>]` / `<leader>[` | next / previous LSP reference of word under cursor           |
| `<C-h/j/k/l>`             | move between windows                                         |
| `jk`                      | leave insert mode                                            |
| `gcc` / `gc`              | toggle comment                                               |
| `ys` / `cs` / `ds`        | add / change / delete surround                               |

## Diagnostics

`lua/diagnostics.lua` keeps the display settings for `vim.diagnostic` (inline
text, gutter signs, severity floor) and exposes the toggles under
`<leader>ud`. Defaults: inline text and signs on, WARN and above. In Rust
buffers `<leader>udra` hides rustc/clippy output from the inline text while
keeping rust-analyzer's, and `<leader>udrc` brings it back.

## Housekeeping

- `:Lazy` updates, cleans, and profiles plugins. `:Lazy profile` is the first
  place to look if startup gets slow.
- `:Mason` manages servers and tools. `:checkhealth` verifies external
  dependencies (ripgrep, make, node, lazygit, …).
- `lazy-lock.json` is git-ignored: each machine tracks the latest plugin
  versions on its own `:Lazy update` schedule. If an update breaks a plugin,
  find the last good commit with `:Lazy log` and pin it with
  `commit = "<hash>"` in that plugin's spec until upstream fixes it.
- Formatting: `stylua .` from the repo root (config in `stylua.toml`), or
  `<leader>bf` in a buffer.
- Sessions are saved per directory on exit by persistence.nvim; nothing is
  restored unless you press `<leader>ss` (or `s` on the dashboard).
- blink.cmp downloads a prebuilt fuzzy-matcher binary on first use. If
  `:checkhealth blink.cmp` says it is missing, run `:Lazy build blink.cmp`.

## Acknowledgements

- [Typecraft](https://www.youtube.com/@typecraft_dev) for the videos that got
  this started.
- [cpow](https://github.com/cpow/neovim-for-newbs/tree/main) for the videos on
  rolling your own config.
- TJ DeVries and [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
  for the LSP, completion, and Telescope setup this borrows heavily from.
- Dillon Mulroy's [config video](https://www.youtube.com/watch?v=oo_I5lAmdi0)
  and [kickstart.nix](https://github.com/dmmulroy/kickstart.nix) for wilder,
  oil, spectre, the lualine harpoon component, and several autocommands.
- [LazyVim](https://github.com/LazyVim/LazyVim) for the gitsigns, snacks, and
  format-on-save patterns.

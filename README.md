# Erik's Neovim config

## Introduction

This config is modular in nature. The top level `init.lua` bootstraps the startup process.
The rest of the config is split into directories and files. All of the config is in the `lua/` directory and the plugins are in the `lua/plugins/` directory. Most of the plugins and their setup/config are in their own files, but a few such as lsp-configuration are groupted in a file with the relevant name.


## Plugins
- alpha
- autopairs 
- catppuccin
- completions
- lazy
- lualine
- mason
- mason-lsp-config
- neotree
- none-ls
- nvim-dap
- nvim-dap-ui
- nvim-lsp-config
- rustaceanvim
- telescope
- treesitter


# Acknowledgements

- Followed instructional videos from [Typecraft](https://www.youtube.com/@typecraft_dev) to learn the basics.
- Thanks to [cpow](https://github.com/cpow/neovim-for-newbs/tree/main) for the videos and helping me learn to roll my own Neovim :)
- Many thanks to TJDevries and [kickstart.vim](https://github.com/nvim-lua/kickstart.nvim) for an amazing setup. I took a lot from his config there but had already started rolling my own config so I didn't want to fork it directly.

- (Alpha Configuration)[https://medium.com/@shaikzahid0713/alpha-start-up-screen-8e4a6e95804d]

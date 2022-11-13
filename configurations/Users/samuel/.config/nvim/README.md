# My Neovim config

Repo contains setup for my nvim config so I don't have to think what I need when
reinstalling.

## Features

This config aims to be pretty lightweight while having features I've found important
for development.

- 100% written in Lua
- Sensible configuration with `vim-sensible` and my keymappings
- LSP, formatting and linting support with `nvim-lspconfig` and `mason`
- Buffers are used instead of tabs
- Fuzzy file search with `telescope.nvim`
- `neogit` for version control
- `neotree` as file explorer
- `doom-one` as the default theme
- And some other minor but useful features, look at `lua/plugins.lua` for the
  full list

## Prerequisites

- terminal, e.g. `iterm2` for macOS
- `neovim >= 0.7.0`
- `packer-nvim` for installing packages
- `ripgrep` for `telescope.nvim`
- for `nvim-web-devicons`, need a patched font in terminal like [FiraCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
- And maybe missing some others... see `:checkhealth` for errors

## Installation

1. `mkdir ~/.config` if it does not exist
2. clone this repo to `~/.config`
3. open neovim
4. run `:PackerSync` to install dependencies
5. do postinstall steps that you want

## Postinstall

### lsp support

- LSP servers should be installed automatically by `mason`
- Add new servers to the `mason` config
- In case of errors see e.g. `:Mason`, `:LspLog`, `:LspInfo`

### misc

- Import the colortheme to `iterm2` for nice match with neovim theme
- Add following to `.zshrc` to support copying e.g. äö to clipboard

```sh
export LC_ALL=en_US.UTF-8
export LANG="UTF-8"
```

- Add `alias ngit="nvim -c Neogit"` to `.zshrc` for quick shortcut to open `neogit`
- Install `typewritten` oh-my-zsh theme (requires `ohmyzsh`)
  - Run `npm install -g typewritten`, restart iterm
  - Set `TYPEWRITTEN_RELATIVE_PATH="adaptive"` in `.zshrc` for relative path
- For commit message support, under ´~/.gitconfig´ add

```sh
...
[core]
  editor = nvim
...
```

## Important commands

Most of the experience is traditional vim, but there are a few important remappings.

- `<Space>` is `<leader>`
- `fd` exits insert mode
- `C-d` moves page down, `C-f` moves page up
- `C-Down` moves one block down, `C-Up` moves one block up
- `<leader>op` opens/closes file tree
- `<leader>F` opens fuzzy file finder
- `<leader>G` opens ripgrep
- `<leader>gg` opens neogit
- `<leader>bb` opens live buffers with search functionality
- `<leader>w<arrow-key>` switches window to that direction
- `<leader>tt` to find `TODO:` etc with telescope
- `<Tab>` and `<Shift-Tab>` switches between open buffers
- And others, see `lua/core/remappings.lua` and `lua/plugins/mason.lua`

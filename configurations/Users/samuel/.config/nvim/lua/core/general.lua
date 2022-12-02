local opt = vim.opt

opt.shell = "zsh"
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.ignorecase = true
opt.cursorline = true
opt.encoding = "UTF-8"
opt.signcolumn = "yes"
opt.termguicolors = true
vim.cmd("autocmd FileType * set formatoptions-=cro")

-- disable plugins for faster startup time
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_matchit = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_spec = 0
vim.g.loaded_remote_plugins = 0

-- " Return to last edit position when opening files
vim.cmd([[
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
]])

-- highlight on yank
vim.cmd([[
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
]])

-- neovide options
if vim.g.neovide then
	-- vim.g.neovide_cursor_vfx_mode = "railgun"
	opt.guifont = "FiraCode Nerd Font:h18"
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_hide_mouse_when_typing = true
end

local opt = vim.opt

opt.shell = "zsh"
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.ignorecase = true
opt.cursorline = true
opt.incsearch = true
opt.scrolloff = 8
opt.encoding = "UTF-8"
opt.grepprg = "rg --vimgrep"
opt.showmode = false
opt.smartindent = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cmdheight = 0
opt.wrap = false -- disable line wrap
vim.cmd("autocmd FileType * set formatoptions-=cro")

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
	opt.guifont = "FiraCode Nerd Font:h20"
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_hide_mouse_when_typing = true
end

vim.opt.shell = "fish"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.encoding = "UTF-8"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.showmode = false
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
-- vim.opt.cmdheight = 0
vim.opt.wrap = true
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
	vim.opt.guifont = "FiraCode Nerd Font:h20"
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_hide_mouse_when_typing = true
end

vim.cmd([[
  autocmd BufEnter *.py :setlocal shiftwidth=4
]])
vim.cmd([[
  autocmd BufEnter *.go :setlocal shiftwidth=2
]])

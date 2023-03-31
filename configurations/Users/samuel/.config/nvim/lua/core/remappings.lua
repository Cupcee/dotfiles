-- Space is <leader>
vim.g.mapleader = " "
local km = vim.keymap

km.set("n", "<SPACE>", "<Nop>")
km.set("n", "<SPACE>o", "<Nop>")

km.set("i", "fd", "<Esc>")

km.set("", ")", "}")
km.set("", "(", "{")

-- auto center screen after navigation
vim.cmd([[
  nnoremap <C-u> <C-u>zz
  nnoremap <C-d> <C-d>zz
  nnoremap } }zz
  nnoremap { {zz
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap <C-j> <C-e>j
  nnoremap <C-k> <C-y>k
  nnoremap G Gzz
]])

-- u is too far away
km.set({ "n", "v" }, "<C-f>", "<C-u>")

km.set("n", "<leader>h", ":set hlsearch!<CR>")

-- keep visual mode selection after shifting
vim.cmd([[
  :vnoremap < <gv
  :vnoremap > >gv
]])

-- window splitting
km.set("n", "<leader>wh", ":split<CR>")
km.set("n", "<leader>wv", ":vsplit<CR>")

-- kill buffer, window
km.set("n", "<leader>bk", ":bd<CR>")
km.set("n", "<leader>wk", ":close<CR>")

-- use tab to switch between buffers
km.set("n", "<tab>", "<C-6>", { silent = true })

-- Harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local silent = { silent = true }

km.set("n", "<leader>ha", function()
	harpoon_mark.add_file()
end, silent)
km.set("n", "<leader>hm", function()
	harpoon_ui.toggle_quick_menu()
end, silent)
km.set("n", "<leader>h1", function()
	harpoon_ui.nav_file(1)
end, silent)
km.set("n", "<leader>h2", function()
	harpoon_ui.nav_file(2)
end, silent)
km.set("n", "<leader>h3", function()
	harpoon_ui.nav_file(3)
end, silent)
km.set("n", "<leader>h4", function()
	harpoon_ui.nav_file(4)
end, silent)

if vim.g.neovide then
	vim.cmd([[
    map <D-v> "+p<CR>
    map! <D-v> <C-R>+
    tmap <D-v> <C-R>+
    vmap <D-c> "+y<CR>
    map <D-d> <C-d>
    map <D-f> <C-f>
    map <D-w> <C-w>
    nnoremap <D-a> <C-a>
    map <D-n> <C-n>
    map <D-N> <C-N>
  ]])
end

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")

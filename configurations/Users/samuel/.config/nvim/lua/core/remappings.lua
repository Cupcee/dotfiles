-- Space is <leader>
vim.g.mapleader = " "
local km = vim.keymap

km.set("n", "<SPACE>", "<Nop>")
km.set("n", "<SPACE>o", "<Nop>")

km.set("i", "fd", "<Esc>")
-- u is too far away
km.set("", "<C-f>", "<C-u>")
km.set("n", "<leader>h", ":set hlsearch!<CR>")

-- keep visual mode selection after shifting
vim.cmd([[
  :vnoremap < <gv
  :vnoremap > >gv
]])

km.set("", ")", "}")
km.set("", "(", "{")

-- NOTE: for practicing without arrow keys
vim.cmd([[
  nnoremap <Up> <Nop>
  nnoremap <Down> <Nop>
  nnoremap <Left> <Nop>
  nnoremap <Right> <Nop>
]])

-- window splitting
km.set("n", "<leader>wh", ":split<CR>")
km.set("n", "<leader>wv", ":vsplit<CR>")

-- kill buffer, window
km.set("n", "<leader>bk", ":bd<CR>")
km.set("n", "<leader>wk", ":close<CR>")

-- remap fuzzy file commands
local telescope_status, telescope = pcall(require, "telescope.builtin")
if telescope_status then
	km.set("n", "<leader>F", telescope.find_files, {})
	km.set("n", "<leader>G", telescope.live_grep, {})
	km.set("n", "<leader>bb", telescope.buffers, {})
end

-- use tab to switch between buffers
km.set("n", "<tab>", "<C-6>", { silent = true })

-- Neotree
km.set("n", "<leader>op", ":Neotree reveal<CR>")

-- neogit
local neogit_status, neogit = pcall(require, "neogit")
if neogit_status then
	km.set("n", "<leader>gg", function()
		neogit.open()
	end)
	km.set("n", "<leader>gc", function()
		neogit.open({ "commit" })
	end)
end

-- todo-comments
local tdc_status, tdc = pcall(require, "todo-comments")
if tdc_status then
	km.set("n", "<leader>tf", ":TodoQuickFix<CR>")
	km.set("n", "<leader>tl", ":TodoLocList<CR>")
	km.set("n", "<leader>tt", ":TodoTelescope<CR>")
	km.set("n", "<leader>xt", ":TodoTrouble<CR>")
	km.set("n", "<leader>tn", function()
		tdc.jump_next()
	end)
	km.set("n", "<leader>tp", function()
		tdc.jump_prev()
	end)
end

-- Trouble
local trouble_km_cfg = { silent = true, noremap = true }
km.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", trouble_km_cfg)
km.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", trouble_km_cfg)
km.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", trouble_km_cfg)
km.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", trouble_km_cfg)
km.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", trouble_km_cfg)
km.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", trouble_km_cfg)

-- Harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local silent = { silent = true }

km.set("n", "<leader>a", function()
	harpoon_mark.add_file()
end, silent)
km.set("n", "<leader>§", function()
	harpoon_ui.toggle_quick_menu()
end, silent)
km.set("n", "<leader>1", function()
	harpoon_ui.nav_file(1)
end, silent)
km.set("n", "<leader>2", function()
	harpoon_ui.nav_file(2)
end, silent)
km.set("n", "<leader>3", function()
	harpoon_ui.nav_file(3)
end, silent)
km.set("n", "<leader>4", function()
	harpoon_ui.nav_file(4)
end, silent)

-- Copilot
-- km.set("n", "<leader>c", "<cmd>Copilot panel<cr><C-w>T")
-- km.set("n", "<leader>cs", "<cmd>Copilot status<cr>")
-- vim.cmd([[
--   imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
--   imap <silent><script><expr> <C-n> copilot#Next()
--   imap <silent><script><expr> <C-N> copilot#Previous()
--   let g:copilot_no_tab_map = v:true
-- ]])

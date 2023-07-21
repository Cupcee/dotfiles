local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	"nvim-lua/plenary.nvim",

	"tpope/vim-surround",
	"tpope/vim-repeat",

	{
		"tpope/vim-fugitive",
		init = function()
			vim.api.nvim_set_keymap("", "<leader>gg", ":tab G<CR>", { noremap = true, silent = true })
		end,
		cmd = { "G", "Gdiffsplit" },
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
			require("treesitter-context").setup()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
	},

	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		config = function()
			require("plugins.copilot")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"kkharji/sqlite.lua",
		},
		cmd = { "Telescope" },
		init = function()
			vim.keymap.set("n", "<leader>F", ":Telescope find_files<cr>", {})
			vim.keymap.set("n", "<leader>G", ":Telescope live_grep<cr>", {})
			vim.keymap.set("n", "<leader>bb", ":Telescope buffers<cr>", {})
		end,
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		enabled = false,
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				trouble = false, -- not needed and this allows easier lazy loading
			})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
		cmd = { "Neotree" },
		init = function()
			vim.keymap.set("n", "<leader>op", ":Neotree reveal<CR>")
		end,
		config = function()
			require("plugins.window-picker")
			require("plugins.neotree")
		end,
	},

	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.dashboard")
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		config = function()
			local tdc = require("todo-comments")
			tdc.setup()
			vim.keymap.set("n", "<leader>tf", ":TodoQuickFix<CR>")
			vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>")
			vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>")
			vim.keymap.set("n", "<leader>tn", function()
				tdc.jump_next()
			end)
			vim.keymap.set("n", "<leader>tp", function()
				tdc.jump_prev()
			end)
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		cmd = { "TroubleToggle", "Trouble" },
		init = function()
			local trouble_km_cfg = { silent = true, noremap = true }
			vim.keymap.set("n", "<leader>xt", ":TodoTrouble<CR>", trouble_km_cfg)
			vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", trouble_km_cfg)
			vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", trouble_km_cfg)
			vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", trouble_km_cfg)
			vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", trouble_km_cfg)
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", trouble_km_cfg)
			vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", trouble_km_cfg)
		end,
		config = function()
			require("trouble").setup({
				use_diagnostic_signs = true,
			})
		end,
	},
	{
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("plugins.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- "rcarriga/nvim-notify",
		},
	},

	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		config = function()
			require("zen-mode").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.indent-blankline")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		enabled = true,
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- autocomplete
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("plugins.nvim-cmp")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- lsp server/format/lint installer
	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.lsp.mason")
		end,
	},

	{
		"jayp0521/mason-null-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("plugins.lsp.mason-null-ls")
			require("plugins.lsp.null-ls")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.lsp.mason-lspconfig")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("plugins.lsp.lspconfig")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
	},
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		cmd = "Lspsaga",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
			})
		end,
	},
	-- file specific
	{ "mechatroner/rainbow_csv", ft = { "csv" } },
	{
		"neanias/everforest-nvim",
		enabled = false,
		priority = 999,
		config = function()
			require("everforest").setup({
				background = "hard",
			})
			vim.cmd.colorscheme("everforest")
		end,
	},
	{
		"seandewar/paragon.vim",
		enabled = false,
		priority = 999,
		config = function()
			vim.cmd.colorscheme("paragon")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = true,
		priority = 999,
		config = function()
			require("kanagawa").setup({
				compile = true,
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
}, {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"nvim-treesitter-textobjects",
			},
		},
	},
})

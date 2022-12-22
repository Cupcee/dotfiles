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
	"wbthomason/packer.nvim",

	"nvim-lua/plenary.nvim",

	"tpope/vim-surround",
	"tpope/vim-repeat",

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"RRethy/nvim-treesitter-textsubjects",
		},
	},

	{
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("plugins.copilot")
			end, 100)
		end,
	},

	{ "kkharji/sqlite.lua" }, -- for telescope-frecency

	-- file finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"kkharji/sqlite.lua",
		},
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- ui
	"MunifTanjim/nui.nvim",
	-- use("rcarriga/nvim-notify")
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
	},

	{ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" },
	{ "goolord/alpha-nvim", requires = "kyazdani42/nvim-web-devicons" },
	{ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" },
	{ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons", cmd = "TroubleToggle" },
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- "rcarriga/nvim-notify",
		},
	},
	"lukas-reineke/indent-blankline.nvim",
	{ "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" } },

	-- autocomplete
	"windwp/nvim-autopairs",

	"windwp/nvim-ts-autotag",
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
	},

	-- snippets
	"L3MON4D3/LuaSnip",
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" } },
	"rafamadriz/friendly-snippets",

	-- lsp server/format/lint installer
	{
		"williamboman/mason.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jayp0521/mason-null-ls.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	-- { "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "glepnir/lspsaga.nvim", branch = "main" },
	"jose-elias-alvarez/typescript.nvim",
	"onsails/lspkind.nvim",

	-- format / lint
	-- { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	-- {
	-- 	"jayp0521/mason-null-ls.nvim",
	-- 	dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
	-- },

	-- file specific
	{ "mechatroner/rainbow_csv", ft = { "csv" } },

	{ "ThePrimeagen/vim-be-good", cmd = { "VimBeGood" } },

	"folke/tokyonight.nvim",
})

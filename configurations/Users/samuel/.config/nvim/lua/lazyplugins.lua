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
		branch = "v2.x",
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
		cmd = "TroubleToggle",
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
			require("trouble").setup()
		end,
	},
	{
		"folke/noice.nvim",
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
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.indent-blankline")
		end,
	},
	{ "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" } },

	-- autocomplete
	{
		event = "InsertEnter",
		"windwp/nvim-autopairs",
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

	-- lsp server/format/lint installer
	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.lsp.mason")
			-- require("plugins.lsp.lspconfig")
			-- require("plugins.lsp.lspsaga")
			-- require("plugins.lsp.null-ls")
		end,
		-- dependencies = {
		-- 	-- "nvim-lua/plenary.nvim",
		-- 	-- "jayp0521/mason-null-ls.nvim",
		-- 	-- "jose-elias-alvarez/null-ls.nvim",
		-- 	-- "williamboman/mason-lspconfig.nvim",
		-- 	-- { "glepnir/lspsaga.nvim", branch = "main" },
		-- 	-- "neovim/nvim-lspconfig",
		-- 	-- "jose-elias-alvarez/typescript.nvim",
		-- 	-- "folke/neodev.nvim",
		-- 	-- "onsails/lspkind.nvim",
		-- },
	},

	{
		event = "BufReadPre",
		"jayp0521/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"black",
					"isort",
					"flake8",
					"prettierd",
					"eslint_d",
					"stylua",
					"clang_format",
					"markdownlint",
					"gofmt",
					"rustfmt",
				},
				automatic_installation = true,
			})
			require("plugins.lsp.null-ls")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"tsserver",
					"html",
					"cssls",
					"sumneko_lua",
					"clangd",
					"terraformls",
					"gopls",
					"bashls",
					"rust_analyzer",
				},
				automatic_installation = true,
			})
		end,
	},

	{
		event = "BufReadPre",
		"neovim/nvim-lspconfig",
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
		event = "BufReadPre",
		config = function()
			require("plugins.lsp.lspsaga")
		end,
	},

	-- file specific
	{ "mechatroner/rainbow_csv", ft = { "csv" } },

	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			require("plugins.tokyonight")
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

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer_status, packer = pcall(require, "packer")
if not packer_status then
	return
end

return packer.startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		use("lewis6991/impatient.nvim")
		use("nvim-lua/plenary.nvim")
		use("kyazdani42/nvim-web-devicons")

		-- extensions to base vim language
		use({
			"tpope/vim-sensible",
			"tpope/vim-surround",
			"tpope/vim-repeat",
			-- "tpope/vim-commentary",
		})

		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
		})
		use({ "nvim-treesitter/nvim-treesitter-context" })

		--use("github/copilot.vim")
		use({
			"zbirenbaum/copilot.lua",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("copilot").setup({
						panel = {
							enabled = true,
							auto_refresh = false,
							keymap = {
								jump_prev = "(",
								jump_next = ")",
								accept = "<CR>",
								refresh = "gr",
								open = "<C-p>",
							},
						},
						suggestion = {
							enabled = true,
							auto_trigger = true,
							debounce = 75,
							keymap = {
								accept = "<C-a>",
								next = "<C-n>",
								prev = "<C-N>",
								dismiss = "<C-d>",
							},
						},
						filetypes = {
							yaml = false,
							markdown = false,
							help = false,
							gitcommit = false,
							gitrebase = false,
							hgcommit = false,
							svn = false,
							cvs = false,
							["."] = false,
						},
						copilot_node_command = "node", -- Node version must be < 18
						plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
						server_opts_overrides = {},
					})
				end, 100)
			end,
		})

		-- org mode
		use({ "nvim-orgmode/orgmode" })
		use({ "akinsho/org-bullets.nvim" })
		use({ "dhruvasagar/vim-table-mode" })

		use({ "kkharji/sqlite.lua" }) -- for telescope-frecency
		-- file finder
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			requires = "nvim-lua/plenary.nvim",
		})

		use({
			"nvim-telescope/telescope-frecency.nvim",
			requires = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" },
		})

		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- ui
		use("MunifTanjim/nui.nvim")
		-- use("rcarriga/nvim-notify")
		use({
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})
		use({ "s1n7ax/nvim-window-picker", tag = "v1.*" })
		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
				"s1n7ax/nvim-window-picker",
			},
		})
		use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
		use({ "goolord/alpha-nvim", requires = "kyazdani42/nvim-web-devicons" })
		use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
		use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
		use({
			"folke/noice.nvim",
			requires = {
				"MunifTanjim/nui.nvim",
				-- "rcarriga/nvim-notify",
			},
		})
		use("lukas-reineke/indent-blankline.nvim")
		use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" })

		-- autocomplete
		use({ "windwp/nvim-autopairs", "windwp/nvim-ts-autotag" })
		use({
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
		})

		-- snippets
		use("L3MON4D3/LuaSnip")
		use({ "saadparwaiz1/cmp_luasnip", requires = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" } })
		use("rafamadriz/friendly-snippets")

		-- lsp server/format/lint installer
		use({
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		})
		use({ "glepnir/lspsaga.nvim", branch = "main" })
		use("jose-elias-alvarez/typescript.nvim")
		use("onsails/lspkind.nvim")

		-- format / lint
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
		use({
			"jayp0521/mason-null-ls.nvim",
			requires = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
		})

		-- file specific
		use({ "mechatroner/rainbow_csv", opt = true, ft = { "csv" } })

		-- random
		use({ "ThePrimeagen/vim-be-good", opt = true, cmd = { "VimBeGood" } })

		-- themes
		use("folke/tokyonight.nvim")

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			packer.sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})

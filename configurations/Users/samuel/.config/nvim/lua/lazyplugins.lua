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

vim.g.mapleader = " "

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
		version = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = { "Telescope" },
		init = function()
			vim.keymap.set("n", "<leader>F", "<cmd>Telescope find_files<cr>", {})
			vim.keymap.set("n", "<leader>G", "<cmd>Telescope live_grep<cr>", {})
			vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", {})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
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
			vim.keymap.set("n", "<leader>op", ":Neotree position=current<CR>")
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
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.indent-blankline")
		end,
	},

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

	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.lsp.mason")
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		config = function()
			require("conform.formatters.isort").args = {
				"--stdout",
				"--filename",
				"$FILENAME",
				"-",
				"--profile",
				"black",
			}
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettierd" },
					go = { "gofmt" },
					rust = { "rustfmt" },
				},
				format_on_save = {
					-- timeout_ms = 500,
					async = true,
					lsp_fallback = true,
				},
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		config = function()
			local plugin = require("lint")
			local flake8 = plugin.linters.flake8
			flake8.args = vim.tbl_flatten({ flake8.args, { "--max-line-length=88", "--extend-ignore=E203" } })
			plugin.linters_by_ft = {
				python = { "flake8" },
				markdown = { "markdownlint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					plugin.try_lint()
				end,
			})
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
			vim.o.updatetime = 250
			vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
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
				finder = {
					keys = {
						toggle_or_open = "<Tab>",
					},
				},
			})
		end,
	},

	{ "mechatroner/rainbow_csv", ft = { "csv" } },

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

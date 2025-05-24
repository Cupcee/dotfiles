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
			require("lualine").setup({
				options = {
					icons_enabled = true,
				},
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = { "Neotree" },
		init = function()
			vim.keymap.set("n", "<leader>op", ":Neotree position=current<CR>")
		end,
		config = function()
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
			tdc.setup({
				highlight = {
					multiline = false,
				},
			})
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
		"folke/zen-mode.nvim",
		lazy = true,
		cmd = { "ZenMode" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			window = {
				width = 160,
				height = 1,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				accept = {
					create_undo_point = true,
					auto_brackets = {
						enabled = true,
					},
				},
				list = {
					selection = {
						auto_insert = false,
						preselect = false,
					},
				},
				documentation = {
					auto_show = true,
				},
			},

			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
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
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- require("conform.formatters.isort").args = {
			-- 	"--stdout",
			-- 	"--filename",
			-- 	"$FILENAME",
			-- 	"-",
			-- 	"--profile",
			-- 	"black",
			-- }
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					go = { "gofmt" },
					rust = { "rustfmt", lsp_format = "fallback" },
				},
				formatters = {
					ruff_organize_imports = {
						command = "ruff",
						args = {
							"check",
							"--force-exclude",
							"--select=I001",
							"--fix",
							"--exit-zero",
							"--stdin-filename",
							"$FILENAME",
							"-",
						},
						stdin = true,
					},
				},
				format_on_save = {
					-- timeout_ms = 500,
					lsp_format = "fallback",
					timeout_ms = 500,
				},
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local plugin = require("lint")
			plugin.linters_by_ft = {
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
		"Goose97/timber.nvim",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("timber").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp.mason-lspconfig")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- require("plugins.lsp.lspconfig")
			-- vim.o.updatetime = 250
			-- vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- go to definition
			vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
		end,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
	},

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		enabled = true,
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
	-- {
	-- 	"rmagatti/goto-preview",
	-- 	dependencies = { "rmagatti/logger.nvim" },
	-- 	event = "BufEnter",
	-- 	config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
	-- },

	{ "mechatroner/rainbow_csv", ft = { "csv" } },

	-- {
	-- 	"rose-pine/neovim",
	-- 	enabled = false,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },
	-- {
	-- 	"iruzo/matrix-nvim",
	--
	-- 	config = function()
	-- 		-- require("darkvoid").setup({
	-- 		-- 	transparent = false,
	-- 		-- 	glow = true,
	-- 		-- })
	-- 		vim.cmd.colorscheme("matrix")
	-- 	end,
	-- },
	{
		"Mofiqul/vscode.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			-- require("darkvoid").setup({
			-- 	transparent = false,
			-- 	glow = true,
			-- })
			vim.o.background = "dark"
			vim.cmd.colorscheme("vscode")
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

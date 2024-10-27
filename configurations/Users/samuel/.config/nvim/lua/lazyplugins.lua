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
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				show = "<D-c>",
				hide = "<S-CR>",
				accept = "<CR>",
				select_next = { "<Tab>", "<Down>" },
				select_prev = { "<S-Tab>", "<Up>" },
				scroll_documentation_down = "<PageDown>",
				scroll_documentation_up = "<PageUp>",
			},
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",

			-- experimental auto-brackets support
			accept = { auto_brackets = { enabled = true } },

			-- experimental signature help support
			trigger = { signature_help = { enabled = true } },
			documentation = {
				auto_show = true,
			},
			windows = {
				documentation = {
					min_width = 15,
					max_width = 50,
					max_height = 15,
					border = vim.g.borderStyle,
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				autocomplete = {
					min_width = 10,
					max_height = 10,
					border = vim.g.borderStyle,
					-- selection = "auto_insert", -- PENDING https://github.com/Saghen/blink.cmp/issues/117
					selection = "manual",
					cycle = { from_top = false }, -- cycle at bottom, but not at the top
					draw = function(ctx)
						-- https://github.com/Saghen/blink.cmp/blob/819b978328b244fc124cfcd74661b2a7f4259f4f/lua/blink/cmp/windows/autocomplete.lua#L285-L349
						-- differentiate LSP snippets from user snippets and emmet snippets
						local icon, source = ctx.kind_icon, ctx.item.source
						local client = source == "LSP" and vim.lsp.get_client_by_id(ctx.item.client_id).name
						if source == "Snippets" or (client == "basics_ls" and ctx.kind == "Snippet") then
							icon = "󰩫"
						elseif source == "Buffer" or (client == "basics_ls" and ctx.kind == "Text") then
							icon = "󰦨"
						elseif client == "emmet_language_server" then
							icon = "󰯸"
						end

						return {
							{
								" " .. ctx.item.label .. " ",
								fill = true,
								hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
								max_width = 45,
							},
							-- { icon .. ctx.icon_gap },
							{ ctx.kind },
						}
					end,
				},
			},
			kind_icons = {
				Text = "󰊄",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "⬟",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "󰒕",
				Color = "󰏘",
				Reference = "",
				File = "󰉋",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			},
		},
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
					-- python = { "isort", "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					go = { "gofmt" },
					rust = { "rustfmt" },
				},
				format_after_save = {
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
			-- local flake8 = plugin.linters.flake8
			-- flake8.args = vim.tbl_flatten({ flake8.args, { "--max-line-length=88", "--extend-ignore=E203" } })
			plugin.linters_by_ft = {
				-- python = { "flake8" },
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
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp.mason-lspconfig")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp.lspconfig")
			vim.o.updatetime = 250
			vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
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

	{ "mechatroner/rainbow_csv", ft = { "csv" } },

	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		name = "rose-pine",
		config = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"aliqyan-21/darkvoid.nvim",
		-- lazy = false,
		enabled = false,
		-- priority = 1000,
		config = function()
			-- require("darkvoid").setup({
			-- 	transparent = false,
			-- 	glow = true,
			-- })
			vim.cmd.colorscheme("darkvoid")
		end,
	},
	-- {
	-- 	"zaldih/themery.nvim",
	-- 	lazy = true,
	-- 	cmd = { "Themery" },
	-- 	config = function()
	-- 		require("themery").setup({
	-- 			themes = {
	-- 				"darkvoid",
	-- 				"rose-pine",
	-- 			},
	-- 			livePreview = true,
	-- 		})
	-- 	end,
	-- },
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

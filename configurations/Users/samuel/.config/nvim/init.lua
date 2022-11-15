require("plugins")
require("impatient")

require("plugins.treesitter")
require("treesitter-context").setup()

require("leap").add_default_mappings()
require("plugins.neogit")
require("plugins.telescope-frecency")
require("plugins.lualine")
require("plugins.indent-blankline")
require("plugins.dashboard")
require("todo-comments").setup()
require("plugins.noice")
require("plugins.window-picker")
require("plugins.neotree")

require("plugins.nvim-cmp")
require("nvim-autopairs").setup()

require("plugins.orgmode")
require("org-bullets").setup()

require("plugins.lsp.mason")
require("plugins.lsp.lspconfig")
require("plugins.lsp.lspsaga")
require("plugins.lsp.null-ls")

require("plugins.tokyonight")

require("core.general")
require("core.remappings")
require("core.theme")

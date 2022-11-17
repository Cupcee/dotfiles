require("mason").setup()

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
	},
	automatic_installation = true,
})

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
	},
	automatic_installation = true,
})

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
		"xmlformatter",
	},
	automatic_installation = false,
})

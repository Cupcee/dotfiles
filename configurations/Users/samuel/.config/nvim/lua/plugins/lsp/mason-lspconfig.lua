require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		-- "tsserver",
		"html",
		"cssls",
		"lua_ls",
		"clangd",
		"terraformls",
		"gopls",
		"bashls",
		"rust_analyzer",
		"tailwindcss",
	},
	automatic_installation = false,
})

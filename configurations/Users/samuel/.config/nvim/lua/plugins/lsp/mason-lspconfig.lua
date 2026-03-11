require("mason-lspconfig").setup({
	ensure_installed = {
		"basedpyright",
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
		"zls",
	},
	automatic_installation = false,
})

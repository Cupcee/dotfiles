require("mason-lspconfig").setup({
  ensure_installed = {
    "basedpyright",
    "lua_ls",
    "rust_analyzer",
  },
  automatic_installation = false,
})

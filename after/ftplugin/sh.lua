local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
vim.lsp.config("bashls", {
  filetypes = { "zsh", "sh", "bash" },
  capabilities = capabilities,
})
vim.lsp.enable("bashls")

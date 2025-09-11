if not vim.lsp.get_clients({ name = "ginko_ls" })[1] then
  vim.lsp.enable("ginko_ls")
end

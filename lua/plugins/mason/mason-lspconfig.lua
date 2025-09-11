return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "mason-org/mason.nvim",
  },
  ---@module "mason-lspconfig"
  ---@class MasonLspconfigSettings
  config = function()
    require("mason-lspconfig").setup({
      automatic_enable = {
        exclude = {
          "rust-analyzer",
          "ts_ls",
        },
      },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}

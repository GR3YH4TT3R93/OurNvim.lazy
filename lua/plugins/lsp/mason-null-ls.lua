return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Opt to list sources here, when available in mason.
        "prettier",
        "eslint-lsp"
      },
      automatic_installation = false,
      handlers = {},
    })
    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        "stylua"
      }
    })
  end,
}

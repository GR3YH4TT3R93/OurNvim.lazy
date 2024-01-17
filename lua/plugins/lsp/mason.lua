return {
  "williamboman/mason.nvim",
  config = function ()
    require("mason").setup({
      automatic_installation = { excludes = "lua_ls" }
    })
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

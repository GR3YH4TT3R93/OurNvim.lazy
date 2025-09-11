return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-shellcheck.nvim",
  },
  config = function()
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    require("mason-null-ls").setup({
      ensure_installed = {},
      automatic_installation = { exclude = { "stylua", "gitsigns" } },
      handlers = {},
    })

    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.gofumpt,
        require("null-ls").builtins.formatting.goimports,
        require("null-ls").builtins.formatting.golines,
        require("null-ls").builtins.formatting.shellharden,
        require("null-ls").builtins.formatting.yamlfix,
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.code_actions.gomodifytags,
        require("null-ls").builtins.code_actions.impl,
        require("null-ls").builtins.code_actions.refactoring,
        require("null-ls").builtins.diagnostics.zsh,
        require("null-ls").builtins.diagnostics.selene,
        require("null-ls").builtins.diagnostics.editorconfig_checker,
        require("null-ls").builtins.diagnostics.golangci_lint,
        require("null-ls").builtins.diagnostics.staticcheck,
        require("null-ls").builtins.diagnostics.todo_comments,
        require("null-ls").builtins.diagnostics.trail_space,
        require("null-ls").builtins.diagnostics.yamllint,
        -- Anythng not supported by none-ls.
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d").with({ timeout = 5000 }),
        require("none-ls.code_actions.eslint_d"),
        require("none-ls.formatting.rustfmt"),
      },
      -- Format on save using null-ls instead of lsp server.
      on_attach = function(current_client, bufnr)
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}

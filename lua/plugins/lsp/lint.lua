---@class LazyPlugin
return {
  "mfussenegger/nvim-lint",
  -- lazy = false,
  name = "nvim-lint",
  event = { "BufReadPost" },
  config = function()
    -- Ensure ESLint_D knows the parent process ID so it knows when to exit
    vim.env.ESLINT_D_PPID = vim.fn.getpid()

    require("lint").linters_by_ft = {
      bash = { "bash", "shellcheck" },
      editorconfig = { "editorconfig-checker" },
      go = { "golangcilint" },
      javascript = { "eslint_d" },
      json = { "jsonlint" },
      lua = { "selene" },
      python = { "ruff" },
      rust = { "clippy" },
      typescript = { "eslint_d" },
      vue = { "eslint_d" },
      zsh = { "zsh", "shellcheck" },
      yaml = { "yamllint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd(
      { "LspAttach", "LspNotify", "TextChanged", "BufWritePre" },
      {
        group = lint_augroup,
        callback = function()
          local client = vim.lsp.get_clients({ bufnr = 0 })[1] or {}
          require("lint").try_lint(nil, { cwd = client.root_dir })
          -- require("lint").try_lint(
          --   nil,
          --   { cwd = client.root_dir or vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h") }
          -- )
        end,
      }
    )
  end,
}

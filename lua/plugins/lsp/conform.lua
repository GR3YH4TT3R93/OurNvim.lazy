---@class LazyPlugin
return {
  "stevearc/conform.nvim",
  event = { "BufReadPost" },
  init = function()
    vim.o.formatexpr = "v:lua require'conform'.formatexpr()"
  end,
  ---@module "conform"
  ---@class conform.setupOpts
  opts = {
    log_level = vim.log.levels.OFF,
    format_on_save = {
      timeout_ms = 1000,
    },
    default_format_opts = {
      async = false,
    },

    formatters_by_ft = {
      ["javascript"] = { "eslint_d" },
      ["javascriptreact"] = { "eslint_d" },
      ["typescript"] = { "eslint_d" },
      ["typescriptreact"] = { "eslint_d" },
      ["vue"] = { "eslint_d" },
      ["css"] = { "eslint_d" },
      ["scss"] = { "eslint_d" },
      ["less"] = { "eslint_d" },
      ["html"] = { "eslint_d" },
      ["json"] = { "jq", "fixjson", "eslint_d" },
      ["jsonc"] = { "biome-check" },
      ["yaml"] = { "yamlfix", "yq" },
      ["markdown"] = { "markdownlint-cli2" },
      ["markdown.mdx"] = { "markdownlint-cli2" },
      ["graphql"] = { "eslint_d" },
      ["handlebars"] = { "eslint_d" },
      ["lua"] = { "stylua" },
      ["rust"] = { "rustfmt" },
      ["go"] = { "gofumpt", "goimports", "golines", "golangci-lint" },
      ["python"] = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      ["zsh"] = { "shellcheck", "shellharden" },
      ["*"] = { "trim_whitespace", "trim_newlines" },
    },
  },
}

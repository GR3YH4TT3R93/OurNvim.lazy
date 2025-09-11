return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = false,
  dependencies = {
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    -- "jay-babu/mason-null-ls.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  opts = {
    ensure_installed = {
      -- you can pin a tool to a particular version
      -- { "golangci-lint", version = "v1.47.0" },
      -- you can turn off/on auto_update per tool
      -- { "bashls", auto_update = true },

      -- Bash
      "bashls",
      "bash-debug-adapter",
      -- "shellcheck",

      -- Go
      "gopls",
      "golangci-lint",
      "gotestsum",
      "gofumpt",
      "golines",
      "gomodifytags",
      "gotests",
      "impl",
      "json-to-struct",
      "staticcheck",
      "delve",
      "gospel",
      "goimports",
      "iferr",
      -- "nilaway",

      -- Lua
      -- "luacheck",
      -- "stylua",
      -- "lua_ls",
      -- "selene",

      -- JavaScript/TypeScript
      "ts_ls",
      "vue_ls",
      "eslint_d",
      "tailwindcss",
      "jsonls",
      "unocss",
      -- "node-debug2-adapter",

      -- random tools
      "emmet-language-server",
      "editorconfig-checker",
      -- "vim-language-server",
      -- "misspell",
      -- "revive",
      -- "shfmt",
      -- "prettierd",
      -- "vint",
    },
    auto_update = true, -- Default: false
    run_on_start = true, -- Default: true
    start_delay = 4000, -- 4 second delay ( Default: 0 )
    debounce_hours = 12, -- at least 1 hour between attempts to install/update
  },
}

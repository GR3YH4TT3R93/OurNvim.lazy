---@class LazyPlugin
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = false,
  dependencies = {
    ---@diagnostic disable-next-line: assign-type-mismatch
    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
        {
          "mason-org/mason.nvim",
          opts = {
            ui = { border = "rounded" },
          },
        },
        "neovim/nvim-lspconfig",
        -- { "GR3YH4TT3R/nvim-lspconfig", dev = true },
      },
      opts = {
        automatic_enable = { exclude = { "rust_analyzer", "ts_ls" } },
      },
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        {
          "mason-org/mason.nvim",
          opts = {},
        },
        { "mfussenegger/nvim-dap" },
        { "rcarriga/nvim-dap-ui", opts = {} },
        "nvim-neotest/nvim-nio",
      },
      opts = {
        ensure_installed = {
          "js-debug-adapter",
        },
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          -- js = function()
          --   require("dap").adapters["pwa-node"] = {
          --     type = "server",
          --     host = "localhost",
          --     port = "${port}",
          --     executable = {
          --       command = "node",
          --       args = {
          --         vim.env.MASON .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          --         "${port}",
          --       },
          --     },
          --   }
          --   require("dap").configurations.javascript = {
          --     {
          --       type = "pwa-node",
          --       request = "launch",
          --       name = "Launch file",
          --       program = "${file}",
          --       cwd = "${workspaceFolder}",
          --     },
          --   }
          -- end,
        },
      },
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    {
      "zapling/mason-lock.nvim",
      opts = {
        lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json",
      },
    },
  },
  opts = {
    ensure_installed = {
      -- Bash
      "bashls",
      "bash-debug-adapter",
      "shellcheck",
      "shellharden",

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

      -- Rust
      "bacon",
      "bacon-ls",

      -- Lua
      {
        "stylua",
        condition = function()
          return not vim.env.TERMUX_VERSION
        end,
      },
      {
        "lua_ls",
        condition = function()
          return not vim.env.TERMUX_VERSION
        end,
      },
      {
        "selene",
        condition = function()
          return not vim.env.TERMUX_VERSION
        end,
      },

      -- Tree-sitter
      {
        "tree-sitter-cli",
        condition = function()
          return not vim.env.TERMUX_VERSION
        end,
      },

      -- Device_Tree
      {
        "ginko_ls",
        condition = function()
          return not vim.env.TERMUX_VERSION
        end,
      },

      -- JavaScript/TypeScript
      -- "ts_ls",
      "vtsls",
      "vue_ls",
      "eslint_d",
      "tailwindcss",
      "unocss",
      "js-debug-adapter",

      -- Python
      "pylsp",
      -- "ruff",

      -- random tools
      "emmet-language-server",
      "editorconfig-checker",
      "markdownlint-cli2",
      -- "vim-language-server",
      -- "misspell",
      -- "revive",
      -- "shfmt",
      -- "prettierd",
      -- "vint",

      -- Json
      "fixjson",
      "jsonls",
      "jsonlint",

      -- Yaml
      "yamlls",
      "yamlfix",
      "yamllint",
    },
    auto_update = true, -- Default: false
    run_on_start = true, -- Default: true
    start_delay = 4000, -- 4 second delay ( Default: 0 )
    debounce_hours = 4, -- at least 1 hour between attempts to install/update
  },
}

return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    { "GR3YH4TT3R93/mason-nvim-dap.nvim", branch = "feat/vue-support" },
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = false },
    "zapling/mason-lock.nvim",
    "folke/lazydev.nvim",
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    ---@type table<string, boolean>
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup({})
    require("mason-tool-installer").setup({
      -- a list of all tools you want to ensure are installed upon start
      ensure_installed = {
        -- you can pin a tool to a particular version
        -- { "golangci-lint", version = "v1.47.0" },
        -- you can turn off/on auto_update per tool
        -- { "bashls", auto_update = true },

        -- Bash
        "bashls",
        "shellcheck",

        -- Go
        "gopls",
        "golangci-lint",
        "gotestsum",
        "nilaway",
        "gofumpt",
        "golines",
        "gomodifytags",
        "gotests",
        "impl",
        "json-to-struct",
        "staticcheck",
        "delve",

        -- Lua
        "luacheck",
        "stylua",
        "lua_ls",
        "selene",

        -- JavaScript/TypeScript
        "tsserver",
        "eslint_d",
        "volar",
        "tailwindcss",
        "jsonls",
        "node-debug2-adapter",

        -- "vim-language-server",
        -- "editorconfig-checker",
        -- "misspell",
        -- "revive",
        -- "shfmt",
        -- "prettierd",
        -- "vint",
      },
      auto_update = true, -- Default: false
      run_on_start = true, -- Default: true
      start_delay = 1000, -- 2 second delay ( Default: 0 )
      debounce_hours = 1, -- at least 1 hour between attempts to install/update
    })

    require("mason-lock").setup({
      lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json", -- (default)
    })
    require("mason-null-ls").setup({
      ensure_installed = {},
      automatic_installation = { exclude = { "stylua", "gitsigns" } },
      handlers = {},
    })

    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.diagnostics.zsh,
        -- require("null-ls").builtins.diagnostics.selene,
        -- require("null-ls").builtins.formatting.gofumpt,
        -- require("null-ls").builtins.formatting.golines,
        -- require("null-ls").builtins.code_actions.gomodifytags,
        -- require("null-ls").builtins.code_actions.impl,
        -- require("null-ls").builtins.diagnostics.golangci_lint,
        -- require("null-ls").builtins.diagnostics.staticcheck,
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d").with({ timeout = 5000 }),
        require("none-ls.code_actions.eslint_d"),
        -- require("none-ls-luacheck.diagnostics.luacheck"),
      },
      -- Format on save using null-ls instead of lsp server.
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })

    require("lazydev").setup({
      library = vim.api.nvim_get_runtime_file("", true),
    })

    require("mason-lspconfig").setup({
      automatic_installation = true,
      handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
        ["volar"] = function()
          require("lspconfig").volar.setup({
            -- NOTE: Uncomment to enable volar in file types other than vue.
            -- (Similar to Takeover Mode)

            -- filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

            -- NOTE: Uncomment to restrict Volar to only Vue/Nuxt projects. This will enable Volar to work alongside other language servers (tsserver).

            -- root_dir = require("lspconfig").util.root_pattern(
            --   "vue.config.js",
            --   "vue.config.ts",
            --   "nuxt.config.js",
            --   "nuxt.config.ts"
            -- ),
            init_options = {
              vue = {
                hybridMode = false,
              },
              -- NOTE: This might not be needed. Uncomment if you encounter issues.

              -- typescript = {
              --   tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
              -- },
              -- inlayHints = {
              --   enabled = true,
              --   -- Only show inlay hints for the following types
              --   only = { "parameter", "type", "enumMember", "function" },
              -- },
            },
            inlayHints = {
              enabled = true,
            },
            capabilities = capabilities,
          })
        end,

        ["tsserver"] = function()
          local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
          local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

          require("lspconfig").tsserver.setup({
            -- NOTE: To enable hybridMode, change HybrideMode to true above and uncomment the following filetypes block.

            -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = volar_path,
                  languages = { "vue" },
                },
              },
            },
            capabilities = capabilities,
            inlayHints = {
              enabled = true,
            },
          })
        end,
      },
    })

    require("mason-nvim-dap").setup({
      ensure_installed = {},
      automatic_installation = true,
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
      },
      -- capabilities = capabilities,
    })

    require("dapui").setup()
  end,
}

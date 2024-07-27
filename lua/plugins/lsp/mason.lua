return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-null-ls.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "zapling/mason-lock.nvim",
    "folke/lazydev.nvim",
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
        -- "shellcheck",

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
        "gospel",
        "goimports",
        "iferr",

        -- Lua
        -- "luacheck",
        -- "stylua",
        -- "lua_ls",
        -- "selene",

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
      start_delay = 1000, -- 1 second delay ( Default: 0 )
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
        require("null-ls").builtins.diagnostics.selene,
        -- Anythng not supported by none-ls.
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d").with({ timeout = 5000 }),
        require("none-ls.code_actions.eslint_d"),
      },
      -- Format on save using null-ls instead of lsp server.
      on_attach = function(current_client, bufnr)
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
            -- capabilities = capabilities,
          })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function()
          --     require("rust-tools").setup {}
          require("lspconfig").rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                inlayHints = {
                  chainingHints = true,
                  typeHints = true,
                  parameterHints = true,
                  maxLength = 25,
                  enumVariant = true,
                  -- parameterHints = {
                  --   mode = "PlainText",
                  -- },
                },
              },
            },
          })
        end,
        ["gopls"] = function()
          require("lspconfig").gopls.setup({
            settings = {
              gopls = {
                hints = {
                  rangeVariableTypes = true,
                  parameterNames = true,
                  constantValues = true,
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  functionTypeParameters = true,
                },
              },
            },
          })
        end,
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
            },
            settings = {
              typescript = {
                inlayHints = {
                  enumMemberValues = {
                    enabled = true,
                  },
                  functionLikeReturnTypes = {
                    enabled = true,
                  },
                  propertyDeclarationTypes = {
                    enabled = true,
                  },
                  parameterTypes = {
                    enabled = true,
                    suppressWhenArgumentMatchesName = true,
                  },
                  variableTypes = {
                    enabled = true,
                  },
                },
              },
            },
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
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                return
              end

              client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    -- vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library",
                    -- "${3rd}/busted/library",
                    -- "~/.local/share/nvim/lazy",
                  },
                },
                hint = {
                  enable = true,
                  arrayIndex = "Auto",
                  await = true,
                  paramName = "All",
                  paramType = true,
                  semicolon = "SameLine",
                  setType = true,
                },
              })
            end,
            settings = {
              Lua = {},
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
    })

    require("dapui").setup()
  end,
}

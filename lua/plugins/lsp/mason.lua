return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-luacheck.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "folke/lazydev.nvim",
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    require("mason").setup({})
    require("mason-tool-installer").setup({
      -- a list of all tools you want to ensure are installed upon start
      ensure_installed = {
        -- you can pin a tool to a particular version
        -- { "golangci-lint", version = "v1.47.0" },
        -- you can turn off/on auto_update per tool
        -- { "bashls", auto_update = true },
        "bashls",
        "shellcheck",
        "gopls",
        "golangci-lint",
        "gotestsum",
        "nilaway",
        "eslint_d",
        "gofumpt",
        "golines",
        "gomodifytags",
        "gotests",
        "impl",
        "json-to-struct",
        "staticcheck",
        "luacheck",
        "volar",
        "tailwindcss",
        "jsonls",
        "node-debug2-adapter",
        -- "stylua",
        -- "lua_ls",
        -- "vim-language-server",
        -- "editorconfig-checker",
        -- "misspell",
        -- "revive",
        -- "shfmt",
        -- "prettierd",
        -- "tsserver",
        -- "vint",
      },
      auto_update = true, -- Default: false
      run_on_start = true, -- Default: true
      start_delay = 2000, -- 2 second delay ( Default: 0 )
      debounce_hours = 1, -- at least 1 hour between attempts to install/update
    })
    require("mason-null-ls").setup({
      automatic_installation = { exclude = { "stylua", "gitsigns" } },
      handlers = {},
    })

    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.diagnostics.zsh,
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d"),
        require("none-ls.code_actions.eslint_d"),
        require("none-ls-luacheck.diagnostics.luacheck"),
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

    require("mason-lspconfig").setup({
      automatic_installation = { exclude = "lua_ls" },
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
            filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
            init_options = {
              vue = {
                hybridMode = false,
              },
              typescript = {
                tsdk = vim.fn.getcwd() .. "/node_modules/typescript",
              },
            },
            capabilities = capabilities,
          })
        end,
        ["tsserver"] = function()
          require("lspconfig").tsserver.setup({
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  -- Change this to the location the plugin is installed to
                  location = home .. "/.local/share/nvm/versions/node/v21.7.1/lib/node_modules/@vue/typescript-plugin",
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            },
            filetypes = {
              "javascript",
              "typescript",
              "vue",
            },
          })
        end,
      },
    })

    require("mason-nvim-dap").setup({
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })
    require("dapui").setup()

    -- Lazydev setup with nvim-dap-ui
    require("lazydev").setup({
      library = { "nvim-dap-ui" },
    })
    -- Servers that are not installed by mason.
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
          },
        })
      end,
      settings = {
        Lua = {},
      },
      capabilities = capabilities,
    })
  end,
}

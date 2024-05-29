return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-luacheck.nvim",
    "RubixDev/mason-update-all",
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- local prefix = os.getenv("PREFIX")

    require("mason").setup({})
    require("mason-update-all").setup({})
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Opt to list sources here, when available in mason.
        -- "prettierd",
        "eslint_d",
      },
      automatic_installation = { exclude = { "stylua", "gitsigns" } },
      handlers = {},
    })

    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.zsh,
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
      ensure_installed = {
        -- Servers that are installed by default in mason.
        "volar",
        -- "tsserver",
        "tailwindcss",
        "bashls",
        "jsonls",
      },
      automatic_installation = { exclude = "lua_ls" },
      handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
        ["volar"] = function()
          require("lspconfig").volar.setup({
            filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
            init_options = {
              vue = {
                hybridMode = false,
              },
              typescript = {
                tsdk = vim.fn.getcwd() .. "node_modules/typescript/lib",
              },
            },
          })
        end,
      },
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
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              "${3rd}/luv/library",
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
  end,
}

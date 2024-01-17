return{
  'neovim/nvim-lspconfig',
  config = function()
    local on_attach = function(_, client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [Actions]")
      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinitions")
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    local lspconfig = require("lspconfig")
    -- local function organize_imports()
    --   local params = {
    --     command = "_typescript.organizeImports",
    --     arguments = { vim.api.nvim_buf_get_name(0) },
    --   }
    --   vim.lsp.buf.execute_command(params)
    -- end

    -- local servers = { "tsserver", "tailwindcss", "pyright", "lua_ls" }
    --
    -- for _, lsp in ipairs(servers) do
    --   lspconfig[lsp].setup({
    --     on_attach: on_attach,
    --     capabilities: capabilities,
    --   })
    -- end
    -- lspconfig.eslint.setup({
    --   on_attach = function(client, bufnr)
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       buffer = bufnr,
    --       command = "EslintFixAll",
    --     })
    --   end,
    -- })

    -- lspconfig.pyright.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { "python" },
    -- })

    -- lspconfig.tsserver.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   init_options = {
    --     preferences = {
    --       disableSuggestions = true,
    --     },
    --   },
    --   commands = {
    --     OrganizeImports = {
    --       organize_imports,
    --       description = "Organize imports",
    --     },
    --   },
    -- })

    -- lspconfig.tailwindcss.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- })
    -- lspconfig.stylelint_lsp.setup{
    --   settings = {
    --     stylelintplus = {
    --       -- see available options in stylelint-lsp documentation
    --     }
    --   }
    -- }
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
-- local lspconfig_configs = require'lspconfig.configs'
-- local lspconfig_util = require 'lspconfig.util'
--
-- local function on_new_config(new_config, new_root_dir)
--   local function get_typescript_server_path(root_dir)
--     local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
--     return project_root and (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
--       or ''
--   end
--
--   if
--     new_config.init_options
--     and new_config.init_options.typescript
--     and new_config.init_options.typescript.tsdk == ''
--   then
--     new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
--   end
-- end
--
-- local volar_cmd = {'vue-language-server', '--stdio'}
-- local volar_root_dir = lspconfig_util.root_pattern 'package.json'
--
-- lspconfig_configs.volar_api = {
--   default_config = {
--     cmd = volar_cmd,
--     root_dir = volar_root_dir,
--     on_new_config = on_new_config,
--     filetypes = { 'vue'},
--     -- If you want to use Volar's Take Over Mode (if you know, you know)
--     --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
--     init_options = {
--       typescript = {
--         tsdk = ''
--       },
--       languageFeatures = {
--         implementation = true, -- new in @volar/vue-language-server v0.33
--         references = true,
--         definition = true,
--         typeDefinition = true,
--         callHierarchy = true,
--         hover = true,
--         rename = true,
--         renameFileRefactoring = true,
--         signatureHelp = true,
--         codeAction = true,
--         workspaceSymbol = true,
--         completion = {
--           defaultTagNameCase = 'both',
--           defaultAttrNameCase = 'kebabCase',
--           getDocumentNameCasesRequest = false,
--           getDocumentSelectionRequest = false,
--         },
--       }
--     },
--   }
-- }
-- lspconfig.volar_api.setup{}
--
-- lspconfig_configs.volar_doc = {
--   default_config = {
--     cmd = volar_cmd,
--     root_dir = volar_root_dir,
--     on_new_config = on_new_config,
--
--     filetypes = { 'vue'},
--     -- If you want to use Volar's Take Over Mode (if you know, you know):
--     --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
--     init_options = {
--       typescript = {
--         tsdk = ''
--       },
--       languageFeatures = {
--         implementation = true, -- new in @volar/vue-language-server v0.33
--         documentHighlight = true,
--         documentLink = true,
--         codeLens = { showReferencesNotification = true},
--         -- not supported - https://github.com/neovim/neovim/pull/15723
--         semanticTokens = false,
--         diagnostics = true,
--         schemaRequestService = true,
--       }
--     },
--   }
-- }
-- lspconfig.volar_doc.setup{}
--
-- lspconfig_configs.volar_html = {
--   default_config = {
--     cmd = volar_cmd,
--     root_dir = volar_root_dir,
--     on_new_config = on_new_config,
--
--     filetypes = { 'vue'},
--     -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
--     --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--     init_options = {
--       typescript = {
--         tsdk = ''
--       },
--       documentFeatures = {
--         selectionRange = true,
--         foldingRange = true,
--         linkedEditingRange = true,
--         documentSymbol = true,
--         -- not supported - https://github.com/neovim/neovim/pull/13654
--         documentColor = false,
--         documentFormatting = {
--           defaultPrintWidth = 100,
--         },
--       }
--     },
--   }
-- }
-- lspconfig.volar_html.setup{}

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  end,
}

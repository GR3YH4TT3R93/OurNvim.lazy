return {
  "hrsh7th/nvim-cmp",
  -- commit = "7e348da6e5085ac447144a2ef4b637220ba27209",
  --
  lazy = true,
  event = "CursorMoved",
  dependencies = {
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-omni",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "petertriho/cmp-git",
    "rafamadriz/friendly-snippets",
    "rcarriga/cmp-dap",
    "SergioRibera/cmp-dotenv",
    "Snikimonkd/cmp-go-pkgs",
    "David-Kunz/cmp-npm",
    "davidsierradz/cmp-conventionalcommits",
  },
  config = function()
    require("cmp-npm").setup({})
    require("cmp_git").setup()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
      Copilot = "",
    }

    require("luasnip.loaders.from_vscode").lazy_load()

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    cmp.setup({
      enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end,
      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" }, -- order of columns,
        format = function(entry, item)
          item.menu = item.kind
          item = require("cmp-tailwind-colors").format(entry, item)
          if kind_icons[item.kind] then
            item.kind = kind_icons[item.kind]
          end
          return item
        end,
      },
      sources = {
        { name = "lazydev" },
        { name = "copilot" },
        { name = "go_pkgs" },
        { name = "npm", keyword_length = 4 },
        { name = "nvim_lsp_signature_help" },
        { name = "conventionalcommits" },
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            -- Check if the buffer type is 'vue'
            if ctx.filetype ~= "vue" then
              return true
            end

            ---@type string
            local cursor_before_line = ctx.cursor_before_line
            -- For events
            if cursor_before_line:sub(-1) == "@" then
              return entry.completion_item.label:match("^@")
              -- For props also exclude events with `:on-` prefix
            elseif cursor_before_line:sub(-1) == ":" then
              return entry.completion_item.label:match("^:") and not entry.completion_item.label:match("^:on-")
            else
              return true
            end
          end,
        },
        { name = "luasnip" },
        { name = "git" },
        {
          name = "omni",
          option = {
            disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
          },
        },
        { name = "buffer" },
        { name = "path" },
        { name = "emoji" },
      },
      completion = {
        completeopt = "menu,menuone,select",
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        ---@type function | table
        completion = cmp.config.window.bordered(),
        ---@type function | table
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<CR>"] = cmp.mapping({
        --   i = function(fallback)
        --     if cmp.visible() and cmp.get_active_entry() then
        --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        --     elseif cmp.visible() and has_words_before() then
        --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        --     else
        --       fallback()
        --     end
        --   end,
        --   -- s = cmp.mapping.confirm({ select = true }),
        --   -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        -- }),
        -- v
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-i>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
        ["<C-g>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-l>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Super Tab Completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "nvim_lsp_document_symbol" },
          { name = "buffer" },
        },
      }),

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      }),
      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      }),
      cmp.setup.filetype({ "gitcommit" }, {
        sources = cmp.config.sources({
          { name = "git" },
          { name = "conventionalcommits" },
          { name = "buffer" },
        }),
      }),
      cmp.setup.filetype("sh", {
        sources = cmp.config.sources({
          { name = "dotenv" },
          { name = "cmdline" },
        }),
      }),
    })
  end,
}

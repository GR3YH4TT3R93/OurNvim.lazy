return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets"
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local kind_icons = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.config.setup({})

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      formatting = {
        fields = { "kind", "abbr", "menu" }, -- order of columns,
        format = function(entry, item)
          if item.kind == "Color" then
            item = require("cmp-tailwind-colors").format(entry, item)

            if item.kind ~= "Color" then
              item.menu = "Color"
              return item
            end
          end

          item.menu = item.kind
          item.kind = kind_icons[item.kind] .. " "
          return item
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        completeopt = "menu, menuone, noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), { 'i' }),

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
      sources = cmp.config.sources({
        { name = 'nvim_lsp'},
        { name = "luasnip" },
        { name = "cmdline" },
        { name = "fuzzy_buffer" },
        { name = "fuzzy_path" },
        { name = "emoji" },
      }),
      -- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'fuzzy_buffer' }
      --   }
      -- }),
      --
      -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'fuzzy_path' }
      --   }, {
      --       { name = 'cmdline' }
      --     })
      -- }),
      --
      --
    })
  end,
}

---@class LazyPlugin
return {
  "saghen/blink.cmp",
  -- build = "cargo build",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    ---@diagnostic disable-next-line: assign-type-mismatch
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    -- "fang2hou/blink-copilot",
    "moyiz/blink-emoji.nvim",
    "MahanRahmati/blink-nerdfont.nvim",
    "Kaiser-Yang/blink-cmp-git",
    "Kaiser-Yang/blink-cmp-dictionary",
    "disrupted/blink-cmp-conventional-commits",
    "alexandre-abrioux/blink-cmp-npm.nvim",
    "nvim-tree/nvim-web-devicons",
    "xzbdmw/colorful-menu.nvim",
    "folke/lazydev.nvim",
    "onsails/lspkind.nvim",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    snippets = { preset = "luasnip" },

    keymap = {

      preset = "default",
      ["<Tab>"] = {
        -- function(cmp)
        --   local has_words_before = function()
        --     local col = vim.api.nvim_win_get_cursor(0)[2]
        --     if col == 0 then
        --       return false
        --     end
        --     return vim.api.nvim_get_current_line():sub(col, col):match("%s")
        --       == nil
        --   end
        --   if has_words_before() then
        --     return cmp.select_next()
        --   end
        -- end,
        "select_next",
        "snippet_forward",
        "fallback",
      },

      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-Space>"] = { "select_and_accept", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {},
    },

    completion = {

      accept = {
        auto_brackets = {
          enabled = true,
        },
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },

      menu = {
        border = "rounded",
        draw = {
          components = {
            -- kind_icon = {
            --
            --   -- text = function(ctx)
            --   --   local lspkind = require("lspkind")
            --   --   local icon = ctx.kind_icon
            --   --   if vim.tbl_contains({ "Path" }, ctx.source_name) then
            --   --     local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
            --   --     if dev_icon then
            --   --       icon = dev_icon
            --   --     end
            --   --   else
            --   --     icon = lspkind.symbolic(ctx.kind, {
            --   --       mode = "symbol",
            --   --     })
            --   --   end
            --   --   return icon .. ctx.icon_gap
            --   -- end,
            --   --
            --   -- highlight = function(ctx)
            --   --   local hl = ctx.kind_hl
            --   --   if vim.tbl_contains({ "Path" }, ctx.source_name) then
            --   --     local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
            --   --     if dev_icon then
            --   --       hl = dev_hl
            --   --     end
            --   --   end
            --   --   return hl
            --   -- end,
            --   text = function(ctx)
            --     -- default kind icon
            --     local icon = ctx.kind_icon
            --     -- if LSP source, check for color derived from documentation
            --     if ctx.item.source_name == "LSP" then
            --       local color_item =
            --         require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
            --       if color_item and color_item.abbr ~= "" then
            --         icon = color_item.abbr
            --       end
            --     end
            --     return icon .. ctx.icon_gap
            --   end,
            --   highlight = function(ctx)
            --     -- default highlight group
            --     local highlight = "BlinkCmpKind" .. ctx.kind
            --     -- if LSP source, check for color derived from documentation
            --     if ctx.item.source_name == "LSP" then
            --       local color_item =
            --         require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
            --       if color_item and color_item.abbr_hl_group then
            --         highlight = color_item.abbr_hl_group
            --       end
            --     end
            --     return highlight
            --   end,
            -- },

            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon

                -- Handle Path source with devicons (from commented code)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ =
                    require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                -- Handle LSP source with color highlighting (from uncommented code)
                elseif ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(
                    ctx.item.documentation,
                    { kind = ctx.kind }
                  )
                  if color_item and color_item.abbr ~= "" then
                    icon = color_item.abbr
                  else
                    -- Fallback to lspkind if no color item
                    local lspkind = require("lspkind")
                    icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                  end
                else
                  -- For other sources, use lspkind
                  local lspkind = require("lspkind")
                  icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                end

                return icon .. ctx.icon_gap
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl

                -- Handle Path source with devicon highlighting (from commented code)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl =
                    require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon and dev_hl then
                    hl = dev_hl
                  end
                -- Handle LSP source with color highlighting (from uncommented code)
                elseif ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(
                    ctx.item.documentation,
                    { kind = ctx.kind }
                  )
                  if color_item and color_item.abbr_hl_group then
                    hl = color_item.abbr_hl_group
                  else
                    -- Fallback to default kind highlight
                    hl = "BlinkCmpKind" .. ctx.kind
                  end
                else
                  -- Default highlight for other sources
                  hl = "BlinkCmpKind" .. ctx.kind
                end

                return hl
              end,
            },
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
          columns = {
            { "label", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
          },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        window = { border = "rounded" },
      },

      ghost_text = {
        enabled = true,
        show_without_selection = true,
      },
    },

    signature = {
      enabled = true,
      -- trigger = { show_on_insert = false },
      -- trigger = { show_on_insert = true },
      window = { border = "rounded" },
    },
    sources = {

      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "omni",
        "dictionary",
        "cmdline",
        -- "copilot",
      },

      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
        gitcommit = {
          "buffer",
          "emoji",
          "nerdfont",
          "git",
          "conventional_commits",
        },
        markdown = {
          "buffer",
          "emoji",
          "nerdfont",
          "git",
          "conventional_commits",
        },
        octo = { "buffer", "emoji", "nerdfont", "git", "conventional_commits" },
        json = { "npm", inherit_defaults = true },
        lua = { "lazydev", inherit_defaults = true },
      },
      providers = {
        -- copilot = {
        --   name = "copilot",
        --   module = "blink-copilot",
        --   score_offset = 100,
        --   async = true,
        --   opts = {
        --     kind_icon = "",
        --   },
        -- },

        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },

        lazydev = {
          name = "LazyDev",
          async = true,
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },

        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },

        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
        },

        git = {
          module = "blink-cmp-git",
          name = "Git",
          opts = {}, -- options for the blink-cmp-git
        },

        conventional_commits = {
          name = "Conventional Commits",
          module = "blink-cmp-conventional-commits",
          opts = {}, -- none so far
        },

        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 4,
          opts = {
            dictionary_directories = {
              vim.fn.stdpath("config") .. "/dict",
            },
          },
        },

        nerdfont = {
          module = "blink-nerdfont",
          name = "Nerd Fonts",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
        },

        npm = {
          name = "npm",
          module = "blink-cmp-npm",
          async = true,
          -- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
          score_offset = 100,
          -- optional - blink-cmp-npm config
          ---@module "blink-cmp-npm"
          ---@class blink-cmp-npm.Options
          opts = {
            ignore = {},
            only_semantic_versions = true,
            only_latest_version = false,
          },
        },
        lsp = {
          opts = {
            tailwind_color_icon = "■",
          },
        },
      },
      -- transform_items = function(ctx, items)
      --   local line = ctx.cursor[1] - 1
      --   local col = ctx.cursor[2]
      --
      --   for _, item in ipairs(items) do
      --     if item.textEdit then
      --       if item.textEdit.range then
      --         -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textEdit
      --         -- trim edit range after cursor
      --         local range_end = item.textEdit.range["end"]
      --         if range_end.line == line and range_end.character > col then
      --           range_end.character = col
      --         end
      --       elseif item.textEdit.insert then
      --         -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#insertReplaceEdit
      --         -- always use insert range
      --         item.textEdit.range = item.textEdit.insert
      --         item.textEdit.replace = nil
      --       end
      --     end
      --   end
      --
      --   return items
      -- end,
    },

    fuzzy = {
      frecency = { enabled = true },
      implementation = "prefer_rust",
    },
  },

  opts_extend = { "sources.default" },
}

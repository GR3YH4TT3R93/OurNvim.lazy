---@class LazyPlugin
return {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter" },
  dependencies = {
    "AndreM222/copilot-lualine",
  },
  opts = {
    options = {
      theme = "onedark",
      disabled_filetypes = {
        statusline = {
          "trouble",
          "dbui",
        },
        winbar = {
          "dbui",
        },
      },
      ignore_focus = {
        "dbui",
        "dashboard",
      },
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "b:gitsigns_head",
          icon = "",
          separator = { right = "" },
        },
        {
          "diff",
          color = { bg = "#31353f" },
          separator = { right = "" or nil },
          source = function()
            local status = vim.b.gitsigns_status_dict
            if status then
              return {
                added = status.added or 0,
                modified = status.changed or 0,
                removed = status.removed or 0,
              }
            end
            return nil
          end,
        },
        {
          "diagnostics",
          symbols = {
            error = " ", -- x000f015a
            warn = " ", -- x000f002a
            info = " ", -- x000f02fd
            hint = "󰌵 ",
          },
          color = { bg = "#31353f" },
          separator = { right = "" },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 4,
          newfile_status = true,
          symbols = {
            modified = "󱇧",
            readonly = "󱆠",
            unnamed = "",
            newfile = "",
          },
        },
      },
      lualine_x = {
        {
          -- function()
          --   return require("lsp-progress").progress {
          --     max_size = 80,
          --     format = function(message)
          --       local active_clients = vim.lsp.get_clients()
          --       if #message > 0 then
          --         return table.concat(message, " ")
          --       end
          --       local client_names = {}
          --       for _, client in ipairs(active_clients) do
          --         if client and client.name ~= "" then
          --           table.insert(client_names, 1, client.name)
          --         end
          --       end
          --       return table.concat(client_names, ", ")
          --     end,
          --   }
          -- end,
          "lsp_status",
          icon = { "", align = "right" },
          show_loading = true,
          color = { bg = "#31353f" },
          separator = { left = "" },
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#d19a66", bg = "#31353f" },
          separator = { left = "" },
        },
        {
          "copilot",
          symbols = {
            status = {
              icons = {
                enabled = "",
                sleep = "", -- auto-trigger disabled
                disabled = "",
                warning = "",
                unknown = "",
              },
              hl = {
                enabled = "#98c379",
                sleep = "#848b98",
                disabled = "#5c6370",
                warning = "#d19a66",
                unknown = "#848b98",
              },
            },
            spinners = "dots",
            spinner_color = "#5c6370",
          },
          show_colors = true,
          show_loading = true,
          color = { bg = "#31353f" },
          separator = { left = "" },
        },
      },
      lualine_y = {
        {
          "filetype",
        },
        -- {
        --   "progress",
        --   color = { bg = "#393f4a" },
        --   separator = { left = "" },
        -- },
      },
      lualine_z = {
        {
          "location",
          fmt = function()
            return "%l %c"
          end,
        },
      },
    },
    tabline = {
      lualine_a = {
        {
          "buffers",
          hide_filename_extension = true,
          mode = 2,
          symbols = { modified = "" },
          filetype_names = {
            TelescopePrompt = "Telescope",
            dashboard = "Dashboard",
            packer = "Packer",
            fzf = "FZF",
            alpha = "Alpha",
          },
        },
      },
      lualine_x = { { color = { bg = "none" } } },
      lualine_y = { { color = { bg = "none" } } },
      lualine_z = { { "tabs", symbols = { modified = "" } } },
    },
    extensions = {
      "lazy",
      "neo-tree",
      "toggleterm",
      "trouble",
      "nvim-dap-ui",
      "mason",
    },
  },
}

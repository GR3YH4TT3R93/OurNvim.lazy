---@class LazyPlugin
return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  event = { "BufEnter" },
  priority = 9999,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    theme = "hyper", --  theme is doom and hyper default is hyper
    disable_move = true, --  default is false disable move keymap for hyper
    shortcut_type = "letter", --  shorcut type "letter" or "number"
    change_to_vcs_root = true, -- default is false,for open file in hyper mru. it will change to the root of vcs
    config = { --  config used for theme
      header = {
        [[░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]],
        [[░░████╗░░░███╗██╗░░░░░░██╗███╗███╗░░░░░░███╗░░]],
        [[░░█████╗░░███║███╗░░░░███║███║████╗░░░░████║░░]],
        [[░░██████╗░███║╚███╗░░███╔╝███║█████╗░░█████║░░]],
        [[░░███╔███╗███║░╚███╗███╔╝░███║███╔█████╔███║░░]],
        [[░░███║░╚█████║░░╚█████╔╝░░███║███║╚███╔╝███║░░]],
        [[░░███║░░╚████║░░░╚███╔╝░░░███║███║░╚█╔╝░███║░░]],
        [[░░███║░░░╚███║░░░░╚█╔╝░░░░███║███║░░╚╝░░███║░░]],
        [[░░╚══╝░░░░╚══╝░░░░░╚╝░░░░░╚══╝╚══╝░░░░░░╚══╝░░]],
        [[░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]],
        [[]],
        [[]],
      },
      packages = { enable = true },
      project = { enable = true },
      week_header = { enable = false },
      shortcut = {
        {
          icon = "󰊳 ",
          desc = "Update Lazy",
          group = "@property",
          action = "Lazy update",
          key = "l",
        },
        {
          icon = "󰊳 ",
          desc = "Update Mason",
          group = "number",
          action = "MasonToolsUpdate",
          key = "m",
        },
        {
          icon = " ",
          desc = "Files",
          group = "Label",
          action = "Telescope find_files",
          key = "f",
        },
        {
          icon = "󰝒 ",
          desc = "New File",
          group = "Label",
          action = function()
            -- Prompt the user for the new file name
            local new_file_name = vim.fn.input("New file name: ")
            if new_file_name ~= "" then
              -- Open the new file
              vim.cmd("edit " .. new_file_name)
            else
              print("No file name provided.")
            end
          end,
          key = "e",
        },
        {
          icon = "󰝰 ",
          desc = "Neo Tree",
          group = "@type",
          action = "Neotree toggle",
          key = "n",
        },
        {
          icon = "󰿅 ",
          desc = "Quit",
          group = "@comment.todo",
          action = "qa",
          key = "q",
        },
      },
    },
    hide = {
      statusline = false, -- hide statusline default is true
      tabline = false, -- hide the tabline
      winbar = false, -- hide winbar
    },
    preview = {
      -- command,       -- preview command
      -- file_path,     -- preview file path
      -- file_height,   -- preview file height
      -- file_width,    -- preview file width
    },
  },
}

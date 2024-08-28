return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  priority = 1000,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("dashboard").setup({
      theme = "hyper", --  theme is doom and hyper default is hyper
      disable_move = true, --  default is false disable move keymap for hyper
      shortcut_type = "number", --  shorcut type "letter" or "number"
      change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
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
            action = "require('lazy').update()",
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
        },
      },
      hide = {
        statusline = false, -- hide statusline default is true
        tabline = true, -- hide the tabline
        winbar = true, -- hide winbar
      },
      preview = {
        -- command,       -- preview command
        -- file_path,     -- preview file path
        -- file_height,   -- preview file height
        -- file_width,    -- preview file width
      },
    })
  end,
}

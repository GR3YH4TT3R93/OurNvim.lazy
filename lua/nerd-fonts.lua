-- local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local devicons = require("nvim-web-devicons")

-- Function to get all icons from nvim-web-devicons
local function get_all_icons()
  local icons = {}
  -- Get all registered icons
  local icon_table = devicons.get_icons()

  -- Add file extension icons
  for name, data in pairs(icon_table) do
    table.insert(icons, {
      name = name,
      icon = data.icon,
      color = data.color,
      cterm_color = data.cterm_color,
      type = "extension",
    })
  end

  -- Get icons by filename
  local filename_icons = devicons.get_icons_by_filename()
  for name, data in pairs(filename_icons) do
    table.insert(icons, {
      name = name,
      icon = data.icon,
      color = data.color,
      cterm_color = data.cterm_color,
      type = "filename",
    })
  end

  -- Get icons by operating system
  local os_icons = devicons.get_icons_by_operating_system()
  for name, data in pairs(os_icons) do
    table.insert(icons, {
      name = name,
      icon = data.icon,
      color = data.color,
      cterm_color = data.cterm_color,
      type = "os",
    })
  end

  -- Get icons by desktop environment
  local de_icons = devicons.get_icons_by_desktop_environment()
  for name, data in pairs(de_icons) do
    table.insert(icons, {
      name = name,
      icon = data.icon,
      color = data.color,
      cterm_color = data.cterm_color,
      type = "desktop",
    })
  end

  -- Get icons by window manager
  local wm_icons = devicons.get_icons_by_window_manager()
  for name, data in pairs(wm_icons) do
    table.insert(icons, {
      name = name,
      icon = data.icon,
      color = data.color,
      cterm_color = data.cterm_color,
      type = "window_manager",
    })
  end

  -- Add default icon
  -- local default_icon, default_color = devicons.get_default_icon()
  -- table.insert(icons, {
  --   name = "default",
  --   icon = default_icon,
  --   color = default_color,
  --   type = "default",
  -- })
  --
  -- -- Add folder icons if available
  -- local folder_icon, folder_color =
  --   devicons.get_icon("folder", nil, { default = true })
  -- if folder_icon then
  --   table.insert(icons, {
  --     name = "folder",
  --     icon = folder_icon,
  --     color = folder_color,
  --     type = "folder",
  --   })
  -- end

  return icons
end

-- Function to create the telescope picker
local function icon_picker(opts)
  opts = opts or {}

  local icons = get_all_icons()

  pickers
    .new(opts, {
      prompt_title = "Nerd Font Icons",
      finder = finders.new_table({
        results = icons,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format(
              "%s  %s (%s)",
              entry.icon,
              entry.name,
              entry.type
            ),
            ordinal = entry.name,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            local icon_data = selection.value
            -- Insert the icon at cursor position
            local icon_text = icon_data.icon
            vim.api.nvim_put({ icon_text }, "c", true, true)

            -- Print info about the selected icon
            print(
              string.format(
                "Inserted: %s (name: %s, type: %s)",
                icon_text,
                icon_data.name,
                icon_data.type
              )
            )
          end
        end)

        -- Add custom mapping to copy icon to clipboard
        map("i", "<C-y>", function()
          local selection = action_state.get_selected_entry()
          if selection then
            local icon_data = selection.value
            vim.fn.setreg("+", icon_data.icon)
            print(string.format("Copied to clipboard: %s", icon_data.icon))
          end
        end)

        -- Add custom mapping to get icon info
        map("i", "<C-i>", function()
          local selection = action_state.get_selected_entry()
          if selection then
            local icon_data = selection.value
            print(
              string.format(
                "Icon: %s | Name: %s | Type: %s | Color: %s",
                icon_data.icon,
                icon_data.name,
                icon_data.type,
                icon_data.color or "none"
              )
            )
          end
        end)

        return true
      end,
    })
    :find()
end

-- Create a command to run the picker
vim.api.nvim_create_user_command("IconPicker", function()
  icon_picker()
end, {})

-- Optional: Create a keymap
vim.keymap.set("n", "<leader>fi", icon_picker, { desc = "Find Icons" })

-- Return the function for use in other scripts
return {
  icon_picker = icon_picker,
  get_all_icons = get_all_icons,
}

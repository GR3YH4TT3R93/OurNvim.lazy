---@class LazyPlugin
return {
  "kylechui/nvim-surround",
  -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = { "VeryLazy" },
  ---@module "nvim-surround"
  ---@class user_options
  opts = {
    move_cursor = "sticky",
  },
}

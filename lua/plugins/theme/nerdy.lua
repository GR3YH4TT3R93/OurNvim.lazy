---@class LazyPlugin
return {
  "2kabhishek/nerdy.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Nerdy" },
  opts = {
    add_default_keymappings = false,
  },
}

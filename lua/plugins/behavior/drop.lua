---@class LazyPlugin
return {
  "folke/drop.nvim",
  event = { "CursorHold" },
  opts = {
    screensaver = 1000 * 60 * 5,
    filetypes = { "alpha", "ministarter" },
    theme = "matrix",
    winblend = 0,
  },
}

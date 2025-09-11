---@type LazyPlugin
return {
  "GR3YH4TT3R93/inlay-hints.nvim",
  lazy = false,
  dev = true,
  ---@module "inlay-hints"
  ---@class inlayHintsConfig
  opts = {
    commands = { enable = true },
    autocmd = { enable = false },
  },
}

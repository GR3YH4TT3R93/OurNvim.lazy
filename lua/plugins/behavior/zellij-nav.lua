---@class LazyPlugin
return {
  "GR3YH4TT3R93/zellij-nav.nvim",
  enabled = os.getenv("ZELLIJ") == "0",
  event = { "BufEnter" },
  dev = true,
  opts = {},
}

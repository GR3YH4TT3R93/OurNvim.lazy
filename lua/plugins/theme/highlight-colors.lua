---@class LazyPlugin
return {
  "brenoprata10/nvim-highlight-colors",

  event = { "BufReadPre" },
  -- dev = true,
  opts = {
    render = "foreground",
    enable_tailwind = true,
  },
}

---@class LazyPlugin
return {
  "vladdoster/remember.nvim",
  -- lazy = false,
  event = { "BufReadPre" },
  opts = {
    remember_ignore_buftype = { "quickfix", "nofile", "help" },
  },
}

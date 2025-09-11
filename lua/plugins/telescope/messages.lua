---@class LazyPlugin
return {
  "d4wns-l1ght/telescope-messages.nvim",
  config = function()
    require("telescope").load_extension("messages")
  end,
}

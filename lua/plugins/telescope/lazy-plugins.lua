---@class LazyPlugin
return {
  "polirritmico/telescope-lazy-plugins.nvim",
  config = function()
    require("telescope").load_extension("lazy_plugins")
  end,
}

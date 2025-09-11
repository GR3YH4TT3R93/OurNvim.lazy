---@class LazyPlugin
return {
  "brookhong/telescope-pathogen.nvim",
  config = function()
    require("telescope").load_extension("pathogen")
  end,
}

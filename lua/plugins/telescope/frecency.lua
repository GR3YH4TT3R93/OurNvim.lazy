---@class LazyPlugin
return {
  "nvim-telescope/telescope-frecency.nvim",
  cmd = { "Telescope frecency" },
  config = function()
    require("telescope").load_extension("frecency")
    vim.api.nvim_set_hl(0, "TelescopePathSeparator", {})
  end,
}

return {
  "nvim-telescope/telescope-frecency.nvim",
  config = function()
    require("telescope").load_extension("frecency")
    vim.api.nvim_set_hl(0, "TelescopePathSeparator", {})
  end,
}

return {
  "nvim-telescope/telescope-frecency.nvim",
  commit = "673585ee997b40d2600eb86c3693d552e4f5d79f",
  config = function()
    require("telescope").load_extension("frecency")
    vim.api.nvim_set_hl(0, "TelescopePathSeparator", {})
  end,
}

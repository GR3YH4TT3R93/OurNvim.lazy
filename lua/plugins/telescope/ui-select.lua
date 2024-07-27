return {
  "nvim-telescope/telescope-ui-select.nvim",
  lazy = false,
  config = function()
    require("telescope").load_extension("ui-select")
  end,
}

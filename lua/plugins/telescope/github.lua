return {
  "nvim-telescope/telescope-github.nvim",
  config = function()
    require("telescope").load_extension("gh")
  end,
}

return {
  "chip/telescope-software-licenses.nvim",
  config = function()
    require("telescope").load_extension("software-licenses")
  end,
}

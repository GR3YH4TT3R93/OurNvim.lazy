return {
  "nguyenvukhang/nvim-toggler",
  event = "CursorMoved",
  config = function()
    require("nvim-toggler").setup()
  end,
}

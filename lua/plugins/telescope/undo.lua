return {
  "debugloop/telescope-undo.nvim",
  config = function()
    require("telescope").load_extension("undo")
  end,
}

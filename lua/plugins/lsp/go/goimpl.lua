return {
  "edolphin-ydf/goimpl.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("telescope").load_extension("goimpl")
  end,
}

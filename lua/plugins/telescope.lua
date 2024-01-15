return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    --   config = function()
    --     -- Telescope
    --   end,
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        undo = {}
      },
    })
    require("telescope").load_extension("undo")
    require("telescope").load_extension("ui-select")
  end,
}

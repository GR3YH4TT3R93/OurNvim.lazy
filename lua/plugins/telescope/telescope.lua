return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = "󱞩 ",
        path_display = { "filename_first" },
        layout_strategy = "vertical",
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        ["licenses-nvim"] = { default_action = "insert" },
        undo = {},
        smart_open = {
          match_algorithm = "fzf",
        },
        frecency = {
          prompt_title = "Frecency",
        },
      },
    })
  end,
}

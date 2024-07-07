return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    debug = false, -- Enable debugging
    show_folds = false,
    show_help = false,
    auto_insert_mode = true,
    -- See Configuration section for rest
    mappings = {
      close = {
        normal = "<leader>x",
        insert = "<leader>x",
      },
    },
  },
}

return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*", -- Use the latest tagged version
  event = "VeryLazy",
  opts = {
    pre_hook = function()
      require("nvim-autopairs").disable()
      require("cmp").setup({ enabled = false })
    end,
    post_hook = function()
      require("nvim-autopairs").enable()
      require("cmp").setup({ enabled = true })
    end,
  }, -- This causes the plugin setup function to be called
  keys = {
    { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i" } },
    { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>" },
    { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
    { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>" },
    { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
    { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },
    { "<Leader>A", "<Cmd>MultipleCursorsAddBySearchV<CR>", mode = { "n", "x" } },
    custom_key_maps = {
      {
        "n",
        "<leader>sa",
        function(_, count, motion_cmd, char)
          vim.cmd("normal " .. count .. "sa" .. motion_cmd .. char)
        end,
        "mc",
      },
    },
  },
}

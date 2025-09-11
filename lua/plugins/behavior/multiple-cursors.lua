---@class LazyPlugin
return {
  "brenton-leighton/multiple-cursors.nvim",
  -- version = "*", -- Use the latest tagged version
  opts = {
    custom_key_maps = {
      {
        { "n", "i" },
        "<C-/>",
        function()
          vim.cmd("normal gcc")
        end,
      },
      {
        "v",
        "<C-/>",
        function()
          vim.cmd("normal gc")
        end,
      },
      {
        "n",
        "<leader>sa",
        function(_, count, motion_cmd, char)
          vim.cmd("normal " .. count .. "sa" .. motion_cmd .. char)
        end,
        "mc",
      },
      {
        "n",
        "<Leader>|",
        function()
          require("multiple-cursors").align()
        end,
      },
    },
  }, -- This causes the plugin setup function to be called
  keys = {
    {
      "<C-k>",
      "<Cmd>MultipleCursorsAddUp<CR>",
      mode = { "n", "x" },
      desc = "Add cursor and move up",
    },
    {
      "<C-Up>",
      "<Cmd>MultipleCursorsAddUp<CR>",
      mode = { "n", "i", "x" },
      desc = "Add cursor and move up",
    },
    {
      "<C-Down>",
      "<Cmd>MultipleCursorsAddDown<CR>",
      mode = { "n", "i", "x" },
      desc = "Add cursor and move down",
    },
    {
      "<C-LeftMouse>",
      "<Cmd>MultipleCursorsMouseAddDelete<CR>",
      mode = { "n", "i" },
      desc = "Add or remove cursor",
    },
    {
      "<Leader>m",
      "<Cmd>MultipleCursorsAddVisualArea<CR>",
      mode = { "x" },
      desc = "Add cursors to the lines of the visual area",
    },
    {
      "<Leader>a",
      "<Cmd>MultipleCursorsAddMatches<CR>",
      mode = { "n", "x" },
      desc = "Add cursors to cword",
    },
    {
      "<Leader>A",
      "<Cmd>MultipleCursorsAddMatchesV<CR>",
      mode = { "n", "x" },
      desc = "Add cursors to cword in previous area",
    },
    {
      "<Leader>d",
      "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
      mode = { "n", "x" },
      desc = "Add cursor and jump to next cword",
    },
    {
      "<Leader>D",
      "<Cmd>MultipleCursorsJumpNextMatch<CR>",
      mode = { "n", "x" },
      desc = "Jump to next cword",
    },
    {
      "<Leader>l",
      "<Cmd>MultipleCursorsLock<CR>",
      mode = { "n", "x" },
      desc = "Lock virtual cursors",
    },
  },
}

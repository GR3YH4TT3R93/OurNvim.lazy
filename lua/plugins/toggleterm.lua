return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  keys = [[<leader>t]],
  opts = {
    open_mapping = [[<leader>t]],
    size = 8,
    insert_mappings = true,
    terminal_mappings = true,
    shade_terminals = false,
    winbar = {
      enabled = false,
    },
  },
}

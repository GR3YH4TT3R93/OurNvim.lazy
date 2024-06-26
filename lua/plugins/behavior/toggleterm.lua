return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    open_mapping = [[<leader>t]],
    size = 8,
    insert_mappings = true,
    terminal_mappings = false,
    shade_terminals = false,
    winbar = {
      enabled = false,
    },
  },
}

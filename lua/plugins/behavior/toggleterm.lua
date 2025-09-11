---@class LazyPlugin
return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    -- open_mapping = [[<C-\>]],
    size = 10,
    insert_mappings = true,
    terminal_mappings = false,
    persist_mode = false,
    shade_terminals = true,
    shading_factor = "-10",
  },
}

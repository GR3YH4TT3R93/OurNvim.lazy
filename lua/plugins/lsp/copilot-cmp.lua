return {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  config = function()
    require("copilot_cmp").setup({
      fix_pairs = true,
    })
  end,
}

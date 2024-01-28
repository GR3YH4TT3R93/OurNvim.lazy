return {
  "brenoprata10/nvim-highlight-colors",
  Lazy = true,
  event = "BufReadPre",
  config = function()
    require("nvim-highlight-colors").setup({ enable_tailwind = true })
  end,
}

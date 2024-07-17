return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufEnter",
  config = function()
    require("nvim-highlight-colors").setup({
      render = "foreground",
      enable_tailwind = true,
    })
  end,
}

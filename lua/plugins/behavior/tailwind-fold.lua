---@class LazyPlugin
return {
  "razak17/tailwind-fold.nvim",
  event = { "BufReadPost" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", branch = "main" },
  },
  ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
  opts = {},
}

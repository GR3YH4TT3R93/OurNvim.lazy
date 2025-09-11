---@class LazyPlugin
return {
  "windwp/nvim-ts-autotag",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", branch = "main" },
  },
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "handlebars",
    "html",
    "vue",
  },
  ---@module "nvim-ts-autotag"
  ---@class nvim-ts-autotag.PluginSetup
  opts = {},
}

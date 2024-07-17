return {
  "windwp/nvim-ts-autotag",
  -- event = "InsertEnter",
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "handlebars",
    "html",
    "vue",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}

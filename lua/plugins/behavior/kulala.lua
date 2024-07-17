return {
  "mistweaverco/kulala.nvim",
  config = function()
    -- Setup is required, even if you don't pass any options
    require("kulala").setup({
      -- default_view, body or headers
      default_view = "default_view",
      -- dev, test, prod, can be anything
      -- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
      default_env = "dev",
      -- enable/disable debug mode
      debug = false,
      inlay = {
        loading_icon = "⏳",
        done_icon = "✅ ",
      },
      lualine = {
        icon = "🐼",
      },
    })
    vim.filetype.add({
      extension = {
        ["http"] = "http",
      },
    })
  end,
}

return {
  "vladdoster/remember.nvim",
  config = function()
    require("remember").setup({
      -- ignore_buftype = { "terminal", "quickfix", "dap-ui", "dap" },
      ignore_filetype = { "dap-repl" },
    })
  end,
}

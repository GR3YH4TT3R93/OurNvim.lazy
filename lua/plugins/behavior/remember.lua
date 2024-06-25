return {
  "vladdoster/remember.nvim",
  -- event = "VeryLazy",
  config = function()
    require("remember").setup({
      -- ignore_buftype = { "terminal", "quickfix", "dap-ui", "dap" },
      ignore_filetype = { "dap-repl" },
    })
  end,
}

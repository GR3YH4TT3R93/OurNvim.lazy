---@class LazyPlugin
return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  dependencies = {
    "numToStr/Comment.nvim",
  },
  event = { "CursorMoved" },
  config = function()
    ---@module "ts_context_commentstring
    ---@class ts_context_commentstring.Config
    require("ts_context_commentstring").setup { enable_autocmd = false }

    require("Comment").setup {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
    --   local get_option = vim.filetype.get_option
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.filetype.get_option = function(filetype, option)
    --     return option == "commentstring"
    --         and require("ts_context_commentstring.internal").calculate_commentstring()
    --       or get_option(filetype, option)
    --   end
  end,
  -- "folke/ts-comments.nvim",
  -- opts = {},
  -- event = "VeryLazy",
  -- enabled = vim.fn.has("nvim-0.10.0") == 1,
}

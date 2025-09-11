---@class LazyPlugin
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre" },
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
    -- "Saghen/blink.pairs",
    { "nvim-treesitter/nvim-treesitter", branch = "main" },
  },
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    local hooks = require("ibl.hooks")

    -- require("blink-pairs").setup { highlights = { groups = highlight } }
    require("rainbow-delimiters.setup").setup { highlight = highlight }

    require("ibl").setup {
      exclude = { filetypes = { "dashboard", "text", "markdown" } },
      indent = {
        highlight = highlight,
        char = "│",
        tab_char = "│",
        repeat_linebreak = true,
        smart_indent_cap = true,
        priority = 9999,
      },
      scope = {
        char = "┃",
        show_start = true,
        show_exact_scope = false,
        priority = 500,
        show_end = false,
        -- injected_languages = true,
        highlight = highlight,
      },
    }
    hooks.register(
      hooks.type.SCOPE_HIGHLIGHT,
      hooks.builtin.scope_highlight_from_extmark
    )
  end,
}

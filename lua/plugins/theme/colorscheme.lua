---@class LazyPlugin
return {
  "navarasu/onedark.nvim",
  -- commit = "b310943f29068d028d16e7a2f72ed9256b23cc4f",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  },
  priority = 999,
  init = function()
    require("onedark").load()
    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = " 󰌵",
        },
      },
    }
  end,
  opts = {
    transparent = true,
    lualine = {
      transparent = true,
    },
    diagnostics = {
      background = false,
    },
    code_style = {
      -- comments = "none",
    },
    highlights = {
      LazyButtonActive = {
        fg = "#98c379",
        bg = "NONE",
      },
    },
  },
}

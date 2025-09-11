-- Bootstrap lazy.nvim
require("lazy-nvim")

-- Add Mise to PATH
-- require("mise")

-- Setup Neovim Settings
require("settings")

-- Setup and enable plugins
---@module "lazy"
---@class LazyConfig
require("lazy").setup {
  spec = {
    { import = "plugins.theme" },
    { import = "plugins.theme.treesitter" },
    { import = "plugins.behavior" },
    { import = "plugins.games" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.lsp.rust" },
    { import = "plugins.lsp.go" },
    { import = "plugins.lsp.typescript" },
    { import = "plugins.lsp.copilot" },
    { import = "plugins.telescope" },
    -- { import = "plugins.snacks" },
  },
  defaults = {
    lazy = true,
  },
  dev = {
    path = "~/GitHub/plugins",
    patterns = { "GR3YH4TT3R93" },
    fallback = true,
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = true,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  install = {
    colorscheme = { "onedark" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
        "tutor",
      },
    },
  },
}

-- Setup Keymaps
require("keymaps")

-- Setup defualt lsp capabilities
require("lsp")

-- Setup Treesitter
require("tree-sitter")
-- require("nerd-fonts")

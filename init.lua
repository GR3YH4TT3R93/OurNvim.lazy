local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.behavior" },
    { import = "plugins.games" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.lsp.rust" },
    { import = "plugins.lsp.go" },
    { import = "plugins.telescope" },
    { import = "plugins.theme" },
  },
  defaults = {
    lazy = true,
  },
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
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
})
require("settings")
require("keymaps")

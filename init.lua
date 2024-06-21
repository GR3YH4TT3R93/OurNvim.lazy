local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.behavior" },
    { import = "plugins.games" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.telescope" },
    { import = "plugins.theme" },
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

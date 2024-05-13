vim.o.encoding = "utf-8"
vim.o.termguicolors = true
vim.o.updatetime = 100
vim.o.autowrite = true
-- vim.o.autochdir = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.scrolloff = 999
vim.o.foldmethod = "marker"
vim.o.compatible = false
vim.o.wrap = true
vim.o.linebreak = true
vim.o.textwidth = 80
vim.o.breakindent = true
vim.o.breakindentopt = "shift:2"
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.lsp.set_log_level("OFF")
vim.notify = require("notify")
vim.o.pumblend = 1

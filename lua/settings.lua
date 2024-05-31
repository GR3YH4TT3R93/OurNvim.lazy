local o = vim.o
local opt = vim.opt

o.encoding = "utf-8"
o.updatetime = 100
o.autowriteall = true
-- o.autochdir = true
o.backup = false
o.writebackup = false
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.number = true
o.relativenumber = true
o.cursorline = true
o.scrolloff = 10
o.foldmethod = "marker"
o.wrap = true
o.linebreak = true
o.textwidth = 80
o.breakindent = true
-- o.breakindentopt = "shift:2"
o.autoindent = true
-- o.expandtab = true
-- o.tabstop = 2
-- o.shiftwidth = 2
-- o.softtabstop = 2
o.pumblend = 1
opt.clipboard = "unnamedplus"
vim.lsp.set_log_level("ERROR")
vim.notify = require("notify")

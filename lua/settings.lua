vim.o.encoding='utf-8'
vim.o.nobackup=true
vim.o.nowritebackup=true
vim.o.signcolumn='yes'
vim.o.number=true
vim.o.relativenumber=true
vim.o.cursorline=true
vim.o.scrolloff=999
vim.o.foldmethod='marker'
vim.o.nocompatible=true
vim.o.wrap=linebreak
vim.o.breakindent=true
vim.o.breakindentopt=shift
vim.o.autoindent=true
vim.o.expandtab=true
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.softtabstop=2
vim.opt.clipboard:append { "unnamed","unnamedplus" }
vim.cmd([[nnoremap <silent> \ :Neotree reveal<cr>]])

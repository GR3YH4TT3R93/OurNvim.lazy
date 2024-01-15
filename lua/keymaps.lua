-- Locals {{{
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
--}}}

-- Move Commands{{{

-- Normal-mode commands{{{
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)
-- }}}

-- Visual-mode commands{{{
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
-- }}}

--}}}

-- Neo Tree Commands{{{
vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', opts) -- }}}

-- LazyGit Commands{{{
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', opts)
--}}}

-- Write Quit eXit {{{
vim.keymap.set('n', '<C-w>', ':w<cr>', opts)
vim.keymap.set('v', '<C-w>', '<esc> :w<cr>', opts)
vim.keymap.set('i', '<C-w>', '<esc> :w<cr>', opts)
vim.keymap.set('n', '<C-q>', ':q!<cr>', opts)
vim.keymap.set('v', '<C-q>', '<esc> :q!<cr>', opts)
vim.keymap.set('i', '<C-q>', '<esc> :q!<cr>', opts)
vim.keymap.set('n', '<C-x>', ':x<cr>', opts)
vim.keymap.set('v', '<C-x>', '<esc> :x<cr>', opts)
vim.keymap.set('i', '<C-x>', '<esc> :x<cr>', opts)
--}]}

-- ToggleTerm Commands{{{
vim.keymap.set('n', '<leader>d', ':TermExec cmd="prd"<CR>')
vim.keymap.set('i', '<leader>d', ':TermExec cmd="prd"<CR>i')
-- }}}

-- Telescope Commands{{{
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fgf", builtin.git_files, {})
vim.keymap.set("n", "<leader>fgs", builtin.git_stash, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>fdt", builtin.lsp_type_definitions, {})
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fdi", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fqf", builtin.quickfix, {})
vim.keymap.set("n", "<leader>fqfh", builtin.quickfixhistory, {})
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>fy', extensions.neoclip.default, {})
--}}}

-- Nvim Space Folding{{{
vim.keymap.set('n', '<Space>', "@=(foldlevel('.')?'za':'\\<Space>')<CR>", opts)
vim.keymap.set('v', '<Space>', 'zf', opts)
-- }}}

-- Close Current Buffer{{{
vim.keymap.set('n', '<leader>bd', ':bd<cr>', opts)
vim.keymap.set('v', '<leader>bd', '<esc> :bd<cr>', opts)
vim.keymap.set('i', '<leader>bd', '<esc> :bd<cr>', opts)
-- }}}

-- Move to Previous and Next Buffer {{{
vim.keymap.set('n', '<C-h>', ':bprev<cr>', opts)
vim.keymap.set('v', '<C-h>', '<esc> :bprev<cr>', opts)
vim.keymap.set('i', '<C-h>', '<esc> :bprev<cr>', opts)

vim.keymap.set('n', '<C-l>', ':bnext<cr>', opts)
vim.keymap.set('v', '<C-l>', '<esc> :bnext<cr>', opts)
vim.keymap.set('i', '<C-l>', '<esc> :bnext<cr>', opts)
-- }}}

-- Eslint{{{

-- Run Eslint with Leader F {{{
vim.keymap.set('n', '<leader>f', 'EslintFixAll', opts)
-- }}}

-- Run Eslint Fix on Write {{{
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue' },
  command = 'silent! EslintFixAll',
  group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
})
vim.api.nvim_create_autocmd({'InsertLeave','TextChanged'}, {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue' },
  command = 'silent! EslintFixAll',
})
-- }}}

--}}}

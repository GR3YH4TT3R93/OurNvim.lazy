vim.api.nvim_set_keymap("n", "[", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CR>", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
vim.opt.splitright = true

return {
  "rmagatti/goto-preview",
  opts = {
      -- focus_on_open = false,
      -- dismiss_on_move = true,
      border = { "↖", "─", "╮", "│", "╯", "─", "╰", "│" },
      post_open_hook = function()
        -- remap gr to close the preview window
        vim.api.nvim_buf_set_keymap(0, "n", "gd", ":close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "gD", ":close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "gr", ":close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "gi", ":close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "gt", ":close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":close<CR>", { noremap = true, silent = true })
      end,
      post_close_hook = function()
        -- unmap gr when the preview window is closed
        vim.keymap.del("n", "gd")
        vim.keymap.del("n", "gD")
        vim.keymap.del("n", "gr")
        vim.keymap.del("n", "gi")
        vim.keymap.del("n", "gt")
        vim.keymap.del("n", "q")
      end,
    }
}

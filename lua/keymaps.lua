-- Locals {{{
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
--}}}

-- Scroll with Mouse {{{
vim.keymap.set("", "<ScrollWheelUp>", "<C-Y>", opts)
vim.keymap.set("i", "<ScrollWheelUp>", "<Esc><C-Y>", opts)
vim.keymap.set("", "<ScrollWheelDown>", "<C-E>", opts)
vim.keymap.set("i", "<ScrollWheelDown>", "<Esc><C-E>", opts)
-- }}}

-- Move Commands{{{

-- Normal-mode commands{{{
vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
vim.keymap.set("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
vim.keymap.set("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
-- }}}

-- Visual-mode commands{{{
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
-- }}}

--}}}

-- Neo Tree Commands{{{
vim.keymap.set("n", "<C-n>", ":Neotree toggle<cr>", opts)
-- }}}

-- LazyGit Commands{{{
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", opts)
--}}}

-- Write Quit eXit {{{
vim.keymap.set("n", "<C-w>", ":w | e | TSBufEnable highlight<cr>", opts)
vim.keymap.set("v", "<C-w>", "<esc> :w | e | TSBufEnable highlight<cr>", opts)
vim.keymap.set("i", "<C-w>", "<esc> :w | e | TSBufEnable highlight<cr>", opts)
vim.keymap.set("n", "<C-q>", ":q!<cr>", opts)
vim.keymap.set("v", "<C-q>", "<esc> :q!<cr>", opts)
vim.keymap.set("i", "<C-q>", "<esc> :q!<cr>", opts)
vim.keymap.set("n", "<C-x>", ":x<cr>", opts)
vim.keymap.set("v", "<C-x>", "<esc> :x<cr>", opts)
vim.keymap.set("i", "<C-x>", "<esc> :x<cr>", opts)
--}}}

-- ToggleTerm Commands{{{
vim.keymap.set("n", "<leader>d", ':TermExec cmd="prd"<CR>', opts)
vim.keymap.set("i", "<leader>d", ':TermExec cmd="prd"<CR>i', opts)
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", opts)
-- }}}

-- Telescope Commands{{{
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fgg", builtin.git_files, opts)
vim.keymap.set("n", "<leader>fgs", builtin.git_stash, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fk", builtin.keymaps, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, opts)
vim.keymap.set("n", "<leader>fdt", builtin.lsp_type_definitions, opts)
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
vim.keymap.set("n", "<leader>fdi", builtin.diagnostics, opts)
vim.keymap.set("n", "<leader>fqf", builtin.quickfix, opts)
vim.keymap.set("n", "<leader>fqfh", builtin.quickfixhistory, opts)
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, opts)
vim.keymap.set("n", "<leader>fy", extensions.neoclip.default, opts)
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, opts)
vim.keymap.set("n", "<leader>u", extensions.undo.undo, opts)
--}}}

-- Nvim Space Folding{{{
vim.keymap.set("n", "<Space>", "@=(foldlevel('.')?'za':'\\<Space>')<CR>", opts)
vim.keymap.set("v", "<Space>", "zf", opts)
-- }}}

-- Close Current Buffer{{{
vim.keymap.set("n", "<leader>bd", ":bd<cr>", opts)
vim.keymap.set("v", "<leader>bd", "<esc> :bd<cr>", opts)
vim.keymap.set("i", "<leader>bd", "<esc> :bd<cr>", opts)
-- }}}

-- Move to Previous and Next Buffer {{{
vim.keymap.set("n", "<C-h>", ":bprev<cr>", opts)
vim.keymap.set("v", "<C-h>", "<esc> :bprev<cr>", opts)
vim.keymap.set("i", "<C-h>", "<esc> :bprev<cr>", opts)

vim.keymap.set("n", "<C-l>", ":bnext<cr>", opts)
vim.keymap.set("v", "<C-l>", "<esc> :bnext<cr>", opts)
vim.keymap.set("i", "<C-l>", "<esc> :bnext<cr>", opts)
-- }}}

-- Run Eslint with Leader lf {{{
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end, opts)
-- }}}

-- Diagnostic Window on CursorHold {{{
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opt = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = "",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opt)
  end,
})
--}}}

-- Notify Mason Update {{{
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsUpdateCompleted",
  callback = function(e)
    vim.schedule(function()
      if #e.data == 0 then
        vim.notify("All LSP servers are up to date!", "info", { title = "mason-tool-installer" })
      end
    end)
  end,
})
--}}}

-- Restore Cursor Position {{{
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
--     if { row, col } ~= { 0, 0 } then
--       vim.api.nvim_win_set_cursor(0, { row, col })
--     end
--   end,
-- })
--}}}

-- Replace Current Word {{{
vim.keymap.set("n", "<Leader>cw", "*Ncgn", opts)
--}}}

-- Debugging Commands {{{
vim.keymap.set("n", "<leader>db", ":lua require('dap').toggle()<CR>", opts)
vim.keymap.set("n", "<leader>dr", ":lua require('dap').repl.toggle()<CR>", opts)
vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>", opts)
vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>", opts)
vim.keymap.set("n", "<leader>ds", ":lua require('dap').step_out()<CR>", opts)
vim.keymap.set("n", "<leader>dd", ":lua require('dap').step_back()<CR>", opts)
vim.keymap.set("n", "<leader>dp", ":lua require('dap').pause()<CR>", opts)
vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>", opts)
vim.keymap.set("n", "<leader>dp", ":lua require('dap').toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opts)
vim.keymap.set("n", "<leader>de", ":lua require('dapui').eval()<CR>", opts)
--}}}

-- LSP Commands {{{

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local op = { buffer = event.buf }

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    -- Diagnostics with Trouble
    -- LSP bindings
    vim.keymap.set("n", "gd", function()
      require("trouble").toggle("lsp_definitions")
    end, op)

    vim.keymap.set("n", "gD", function()
      require("trouble").toggle("lsp_declarations")
    end, op)

    vim.keymap.set("n", "gi", function()
      require("trouble").toggle("lsp_implementations")
    end, op)

    vim.keymap.set("n", "gt", function()
      require("trouble").toggle("lsp_type_definitions")
    end, op)

    vim.keymap.set("n", "gr", function()
      require("trouble").toggle("lsp_references")
    end, op)

    vim.keymap.set("n", "[d", function()
      if vim.tbl_isempty(vim.diagnostic.get(0)) then
        require("trouble").close("diagnostics")
        vim.notify("No diagnostic errors found", "info", { title = "Trouble" })
      else
        vim.diagnostic.goto_prev()
        require("trouble").prev({ mode = "diagnostics" })
      end
    end, op)

    vim.keymap.set("n", "]d", function()
      if vim.tbl_isempty(vim.diagnostic.get(0)) then
        require("trouble").close("diagnostics")
        vim.notify("No diagnostic errors found", "info", { title = "Trouble" })
      else
        vim.diagnostic.goto_next()
        require("trouble").next({ mode = "diagnostics" })
      end
    end, op)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, op)
    -- vim.keymap.set("n", "gd", function()
    --   vim.lsp.buf.definition()
    -- end, op)
    vim.keymap.set("n", "gs", function()
      vim.lsp.buf.signature_help()
    end, op)
    vim.keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, op)
    -- Format and Code Actions
    vim.keymap.set({ "n", "x" }, "<leader>fm", function()
      vim.lsp.buf.format({ async = true })
    end, op)
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, op)
  end,
})
--}}}

-- Fix Treesitter Highlighting {{{
vim.keymap.set("n", "<leader>ts", ":write | edit | TSBufEnable highlight<CR>", opts)
-- }}}

-- Remap j and k to gj and gk {{{
--[[ vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts) ]]
-- }}}

-- Trouble Commands {{{
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle("diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
-- }}}

-- VimBeGood Commands {{{
vim.keymap.set("n", "<leader>bg", ":VimBeGood<CR>", opts)
--}}}

-- Locals {{{
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
local bufnr = vim.api.nvim_get_current_buf()
local chat = require("CopilotChat")
--}}}

-- Scroll with Mouse {{{
vim.keymap.set("", "<ScrollWheelUp>", "<C-Y>", opts)
vim.keymap.set("i", "<ScrollWheelUp>", "<Esc><C-Y>", opts)
vim.keymap.set("", "<ScrollWheelDown>", "<C-E>", opts)
vim.keymap.set("i", "<ScrollWheelDown>", "<Esc><C-E>", opts)
-- }}}

-- Move Commands {{{

-- Normal-mode commands {{{
vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
vim.keymap.set("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
vim.keymap.set("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
-- }}}

-- Visual-mode commands {{{
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
-- }}}

--}}}

-- Neo Tree Commands {{{
vim.keymap.set("n", "<C-n>", ":Neotree toggle<cr>", opts)
vim.keymap.set("n", "<C-n>s", ":Neotree git_status<cr>", opts)
-- }}}

-- LazyGit Commands {{{
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", opts)
--}}}

-- Window Management {{{
vim.keymap.set({ "n", "t" }, "<leader>h", "<C-w>h", opts)
vim.keymap.set({ "n", "t" }, "<leader>j", "<C-w>j", opts)
vim.keymap.set({ "n", "t" }, "<leader>k", "<C-w>k", opts)
vim.keymap.set({ "n", "t" }, "<leader>l", "<C-w>l", opts)
vim.keymap.set({ "n", "t" }, "<leader>s", "<C-w>s", opts)
vim.keymap.set({ "n", "t" }, "<leader>v", "<C-w>v", opts)
vim.keymap.set({ "n", "t" }, "<leader>x", "<C-w>c", opts)
vim.keymap.set({ "n", "t" }, "<leader>w=", "<C-w>=", opts)
vim.keymap.set({ "n", "t" }, "<leader>w-", "<C-w>-", opts)
vim.keymap.set({ "n", "t" }, "<leader>w+", "<C-w>+", opts)
vim.keymap.set({ "n", "t" }, "<leader>w<", "<C-w><", opts)
vim.keymap.set({ "n", "t" }, "<leader>w>", "<C-w>>", opts)
vim.keymap.set({ "n", "t" }, "<leader>w_", "<C-w>_", opts)
vim.keymap.set({ "n", "t" }, "<leader>w|", "<C-w>|", opts)
vim.keymap.set({ "n", "t" }, "<leader>w", [[<C-\><C-n><C-w>]], opts)
vim.keymap.set({ "t" }, "<esc><esc>", [[<C-\><C-n>]], opts)
-- }}}

-- Write Quit eXit {{{
vim.keymap.set("n", "<C-W>", ":w | e | TSBufEnable highlight<cr>", opts)
vim.keymap.set("v", "<C-W>", "<esc> :w | e | TSBufEnable highlight<cr>", opts)
vim.keymap.set("i", "<C-W>", "<esc> :w | e | TSBufEnable highlight<cr>", opts)
vim.keymap.set("n", "<C-q>", ":q!<cr>", opts)
vim.keymap.set("v", "<C-q>", "<esc> :q!<cr>", opts)
vim.keymap.set("i", "<C-q>", "<esc> :q!<cr>", opts)
vim.keymap.set("n", "<C-x>", ":x<cr>", opts)
vim.keymap.set("v", "<C-x>", "<esc> :x<cr>", opts)
vim.keymap.set("i", "<C-x>", "<esc> :x<cr>", opts)
--}}}

-- ToggleTerm Commands {{{
vim.keymap.set("n", "<leader>d", ':TermExec cmd="prd"<CR>', opts)
vim.keymap.set("i", "<leader>d", ':TermExec cmd="prd"<CR>i', opts)
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", opts)
vim.keymap.set("n", "<leader>tx", ":ToggleTerm close<CR>", opts)
-- }}}

-- Telescope Commands {{{
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files()
end, opts)
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep()
end, opts)
vim.keymap.set("n", "<leader>fgg", function()
  builtin.git_files()
end, opts)
vim.keymap.set("n", "<leader>fgb", function()
  builtin.git_branches()
end, opts)
vim.keymap.set("n", "<leader>fgc", function()
  builtin.git_bcommits()
end, opts)
vim.keymap.set("n", "<leader>fgs", function()
  builtin.git_stash()
end, opts)
vim.keymap.set("n", "<leader>fb", function()
  builtin.buffers()
end, opts)
vim.keymap.set("n", "<leader>fk", function()
  builtin.keymaps()
end, opts)
vim.keymap.set("n", "<leader>fh", function()
  builtin.help_tags()
end, opts)
vim.keymap.set("n", "<leader>fd", function()
  builtin.lsp_definitions()
end, opts)
vim.keymap.set("n", "<leader>fdt", function()
  builtin.lsp_type_definitions()
end, opts)
vim.keymap.set("n", "<leader>fr", function()
  builtin.lsp_references()
end, opts)
vim.keymap.set("n", "<leader>fdi", function()
  builtin.diagnostics()
end, opts)
vim.keymap.set("n", "<leader>fq", function()
  builtin.quickfix()
end, opts)
vim.keymap.set("n", "<leader>fqh", function()
  builtin.quickfixhistory()
end, opts)
vim.keymap.set("n", "<leader>fi", function()
  builtin.lsp_implementations()
end, opts)
vim.keymap.set("n", "<leader>fs", function()
  builtin.lsp_document_symbols()
end, opts)
vim.keymap.set("n", "<leader>fy", function()
  extensions.neoclip.default()
end, opts)
vim.keymap.set("n", "<leader>fu", function()
  extensions.undo.undo()
end, opts)
vim.keymap.set("n", "<leader>fms", function()
  extensions.macroscope.default()
end, opts)
vim.keymap.set("n", "<leader><leader>", function()
  extensions.frecency.frecency()
end, opts)
vim.keymap.set("n", "<leader>fl", function()
  require("telescope._extensions.software-licenses").exports.find()
end, opts)
vim.keymap.set("n", "<leader>ft", function()
  require("telescope._extensions.todo-comments").exports.todo()
end, opts)
vim.keymap.set("n", "<leader>fw", function()
  extensions.smart_open.smart_open()
end, opts)
--}}}

-- Nvim Space Folding {{{
vim.keymap.set("n", "<Space>", "@=(foldlevel('.')?'za':'\\<Space>')<CR>", opts)
vim.keymap.set("v", "<Space>", "zf", opts)
-- }}}

-- Close Current Buffer {{{
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
        vim.notify("All LSP servers are up-to-date!", "info", { title = "mason-tool-installer" })
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
      require("goto-preview").goto_preview_definition()
    end, op)

    vim.keymap.set("n", "gD", function()
      require("goto-preview").goto_preview_declaration()
    end, op)

    vim.keymap.set("n", "gi", function()
      require("goto-preview").goto_preview_implementation()
    end, op)

    vim.keymap.set("n", "gt", function()
      require("goto-preview").goto_preview_type_definition()
    end, op)

    vim.keymap.set("n", "gr", function()
      require("goto-preview").goto_preview_references()
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

-- TODO Comments {{{
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, opts)

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, opts)
-- }}}

-- VimBeGood Commands {{{
vim.keymap.set("n", "<leader>bg", ":VimBeGood<CR>", opts)
--}}}

-- Copilot Chat Commands {{{
vim.keymap.set("n", "<leader>cc", function()
  chat.toggle({
    window = {
      layout = "float",
      title = "Copilot Chat",
    },
  })
end, opts)

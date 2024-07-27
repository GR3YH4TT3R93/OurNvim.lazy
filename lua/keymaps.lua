-- -- Locals {{{
--
local telescopepath = vim.fn.stdpath("data") .. "/lazy/telescope.nvim"
local CopilotChatpath = vim.fn.stdpath("data") .. "/lazy/CopilotChat.nvim"
if (vim.uv or vim.loop).fs_stat(telescopepath and CopilotChatpath) then
  local map = vim.keymap.set
  local aucmd = vim.api.nvim_create_autocmd
  local opts = { noremap = true, silent = true }
  local bufnr = vim.api.nvim_get_current_buf()
  --}}}

  -- Scroll with Mouse {{{
  map("", "<ScrollWheelUp>", "<C-Y>", opts)
  map("i", "<ScrollWheelUp>", "<Esc><C-Y>", opts)
  map("", "<ScrollWheelDown>", "<C-E>", opts)
  map("i", "<ScrollWheelDown>", "<Esc><C-E>", opts)
  -- }}}

  -- Move Commands {{{

  -- Normal-mode commands {{{
  -- map("n", "lh", ":MoveHChar(-1)<CR>", opts)
  map("n", "lj", ":MoveLine(1)<CR>", opts)
  map("n", "lk", ":MoveLine(-1)<CR>", opts)
  map("n", "ll", ":MoveHChar(1)<CR>", { nowait = false })
  map("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
  map("n", "<leader>wb", ":moveWord(-1)<CR>", opts)
  map("n", "<Shift>|", function()
    require("multiple-cursors").align()
  end, opts)
  -- }}}

  -- Visual-mode commands {{{
  map("x", "<A-j>", ":MoveBlock(1)<CR>", opts)
  map("x", "<A-k>", ":MoveBlock(-1)<CR>", opts)
  map("x", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
  map("x", "<A-l>", ":MoveHBlock(1)<CR>", opts)
  -- }}}

  --}}}

  -- Neo Tree Commands {{{
  map("n", "<C-n>", ":Neotree toggle<cr>", opts)
  map("n", "<C-n>s", ":Neotree git_status<cr>", opts)
  -- }}}

  -- LazyGit Commands {{{
  map("n", "<leader>gg", ":LazyGit<CR>", opts)
  aucmd("BufEnter", {
    pattern = "*",
    callback = function()
      require("lazygit.utils").project_root_dir()
    end,
  })
  --}}}

  -- Window Management {{{
  map({ "n", "t" }, "<A-h>", "<C-w>h", opts)
  map({ "n", "t" }, "<A-j>", "<C-w>j", opts)
  map({ "n", "t" }, "<A-k>", "<C-w>k", opts)
  map({ "n", "t" }, "<A-l>", "<C-w>l", opts)
  map({ "n", "t" }, "<A-s>", "<C-w>s", opts)
  map({ "n", "t" }, "<A-v>", "<C-w>v", opts)
  map({ "n", "t" }, "<A-x>", "<C-w>c", opts)
  map({ "n", "t" }, "<A-=>", "<C-w>=", opts)
  map({ "n", "t" }, "<A-->", "<C-w>-", opts)
  map({ "n", "t" }, "<A-+>", "<C-w>+", opts)
  map({ "n", "t" }, "<A-\\<>", "<C-w><", opts)
  map({ "n", "t" }, "<A-\\>>", "<C-w>>", opts)
  map({ "n", "t" }, "<A-\\_>", "<C-w>_", opts)
  map({ "n", "t" }, "<A-\\|>", "<C-w>|", opts)
  map({ "n", "t" }, "<A-p>", [[<C-\><C-n><C-w>]], opts)
  map({ "t" }, "<esc><esc>", [[<C-\><C-n>]], opts)
  -- }}}

  -- Save Quit eXit {{{
  map("n", "<C-s>", ":w | e | TSBufEnable highlight<cr>", opts)
  map("x", "<C-s>", "<esc> :w | e | TSBufEnable highlight<cr>", opts)
  map("i", "<C-s>", "<esc> :w | e | TSBufEnable highlight<cr>i", opts)
  map("n", "<C-Shift>s", ":wa | e | TSEnable highlight<cr>", opts)
  map("x", "<C-Shift>s", "<esc>:wa | e | TSEnable highlight<cr>", opts)
  map("i", "<C-Shift>s", "<esc>:wa | e | TSEnable highlight<cr>i", opts)
  map("n", "<C-q>", ":q!<cr>", opts)
  map("x", "<C-q>", "<esc> :q!<cr>", opts)
  map("i", "<C-q>", "<esc> :q!<cr>", opts)
  map("n", "<C-x>", ":x<cr>", opts)
  map("x", "<C-x>", "<esc> :x<cr>", opts)
  map("i", "<C-x>", "<esc> :x<cr>", opts)
  --}}}

  -- ToggleTerm Commands {{{
  map("n", "<leader>d", ':TermExec cmd="prd"<CR>', opts)
  map("i", "<leader>d", ':TermExec cmd="prd"<CR>i', opts)
  map("n", "<leader>t", ":ToggleTerm<CR>", opts)
  map("n", "<leader>tx", ":ToggleTerm close<CR>", opts)
  -- }}}

  -- Telescope Commands {{{
  map("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
  end, opts)
  map("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
  end, opts)
  map("n", "<leader>fgg", function()
    require("telescope").extensions.lazygit.lazygit()
  end, opts)
  map("n", "<leader>fgf", function()
    require("telescope.builtin").git_files()
  end, opts)
  map("n", "<leader>fgb", function()
    require("telescope.builtin").git_branches()
  end, opts)
  map("n", "<leader>fgc", function()
    require("telescope.builtin").git_bcommits()
  end, opts)
  map("n", "<leader>fgs", function()
    require("telescope.builtin").git_stash()
  end, opts)
  map("n", "<leader>fb", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
  end, opts)
  map("n", "<leader>fB", function()
    require("telescope.builtin").buffers()
  end, opts)
  map("n", "<leader>fk", function()
    require("telescope.builtin").keymaps()
  end, opts)
  map("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
  end, opts)
  map("n", "<leader>fd", function()
    require("telescope.builtin").lsp_definitions()
  end, opts)
  map("n", "<leader>fdt", function()
    require("telescope.builtin").lsp_type_definitions()
  end, opts)
  map("n", "<leader>fr", function()
    require("telescope.builtin").lsp_references()
  end, opts)
  map("n", "<leader>fdi", function()
    require("telescope.builtin").diagnostics()
  end, opts)
  map("n", "<leader>fq", function()
    require("telescope.builtin").quickfix()
  end, opts)
  map("n", "<leader>fqh", function()
    require("telescope.builtin").quickfixhistory()
  end, opts)
  map("n", "<leader>fi", function()
    require("telescope.builtin").lsp_implementations({})
  end, opts)
  map("n", "<leader>fs", function()
    require("telescope.builtin").lsp_document_symbols({})
  end, opts)
  map("n", "<leader>fy", function()
    require("telescope").extensions.neoclip.default({})
  end, opts)
  map("n", "<leader>fu", function()
    require("telescope").extensions.undo.undo({})
  end, opts)
  map("n", "<leader>fms", function()
    require("telescope").extensions.macroscope.default({})
  end, opts)
  map("n", "<leader><leader>", function()
    require("telescope").extensions.frecency.frecency({})
  end, opts)
  map("n", "<leader>fl", function()
    require("telescope._extensions.licenses-nvim").exports.insert()
  end, opts)
  map("n", "<leader>flp", function()
    require("licenses").write_license("LICENSE", require("licenses").get_config(vim.api.nvim_get_current_buf()))
  end, opts)
  map("n", "<leader>ft", function()
    require("telescope._extensions.todo-comments").exports.todo({})
  end, opts)
  map("n", "<leader>fw", function()
    require("telescope").extensions.smart_open.smart_open({})
  end, opts)
  map("n", "<leader>fn", function()
    require("telescope").extensions.nerdy.nerdy({})
  end, opts)
  --}}}

  -- Nvim Space Folding {{{
  map("n", "<Space>", "@=(foldlevel('.')?'za':'\\<Space>')<CR>", opts)
  map("x", "<Space>", "zf", opts)
  -- }}}

  -- Close Current Buffer {{{
  map("n", "<leader>bd", ":bd<cr>", opts)
  map("x", "<leader>bd", "<esc> :bd<cr>", opts)
  map("i", "<leader>bd", "<esc> :bd<cr>", opts)
  -- }}}

  -- Move to Previous and Next Buffer {{{
  map("n", "<C-h>", ":bprev<cr>", opts)
  map("x", "<C-h>", "<esc> :bprev<cr>", opts)
  map("i", "<C-h>", "<esc> :bprev<cr>", opts)

  map("n", "<C-l>", ":bnext<cr>", opts)
  map("x", "<C-l>", "<esc> :bnext<cr>", opts)
  map("i", "<C-l>", "<esc> :bnext<cr>", opts)
  -- }}}

  -- Run Eslint with Leader lf {{{
  map("n", "<leader>lf", function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end, opts)
  -- }}}

  -- Diagnostic Window on CursorHold {{{
  aucmd("CursorHold", {
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
  aucmd("User", {
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
  -- aucmd("BufReadPost", {
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
  map("n", "<Leader>cw", "*Ncgn", opts)
  --}}}

  -- Debugging Commands {{{
  map("n", "<leader>dt", function()
    require("dap").toggle_breakpoint()
  end, opts)
  map("n", "<leader>dr", function()
    require("dap").repl.toggle()
  end, opts)
  map("n", "<leader>di", function()
    require("dap").step_into()
  end, opts)
  map("n", "<leader>do", function()
    require("dap").step_over()
  end, opts)
  map("n", "<leader>ds", function()
    require("dap").step_out()
  end, opts)
  map("n", "<leader>dd", function()
    require("dap").step_back()
  end, opts)
  map("n", "<leader>dp", function()
    require("dap").pause()
  end, opts)
  map("n", "<leader>dc", function()
    require("dap").continue()
  end, opts)
  map("n", "<Leader>dl", function()
    require("dap").run_last()
  end, opts)
  map("n", "<leader>du", function()
    require("dapui").toggle()
  end, opts)
  map("n", "<leader>de", function()
    require("dapui").eval()
  end, opts)
  --}}}

  -- LSP Commands {{{

  aucmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      local op = { buffer = event.buf }

      -- these will be buffer-local keybindings
      -- because they only work if you have an active language server
      -- Diagnostics with Trouble
      -- LSP bindings
      map("n", "gd", function()
        require("goto-preview").goto_preview_definition({})
      end, op)

      map("n", "gD", function()
        require("goto-preview").goto_preview_declaration({})
      end, op)

      map("n", "gi", function()
        require("goto-preview").goto_preview_implementation({})
      end, op)

      map("n", "gt", function()
        require("goto-preview").goto_preview_type_definition({})
      end, op)

      map("n", "gr", function()
        require("goto-preview").goto_preview_references({})
      end, op)

      map("n", "[d", function()
        if vim.tbl_isempty(vim.diagnostic.get(0)) then
          require("trouble").close("diagnostics")
          vim.notify("No diagnostic errors found", "info", { title = "Trouble" })
        else
          vim.diagnostic.goto_prev()
          require("trouble").prev({ mode = "diagnostics" })
        end
      end, op)

      map("n", "]d", function()
        if vim.tbl_isempty(vim.diagnostic.get(0)) then
          require("trouble").close("diagnostics")
          vim.notify("No diagnostic errors found", "info", { title = "Trouble" })
        else
          vim.diagnostic.goto_next()
          require("trouble").next({ mode = "diagnostics" })
        end
      end, op)
      -- map("n", "K", function()
      --   vim.lsp.buf.hover()
      -- end, op)
      map("n", "gs", function()
        vim.lsp.buf.signature_help()
      end, op)
      map("n", "<leader>rn", function()
        vim.lsp.buf.rename()
      end, op)
      -- Format and Code Actions
      map({ "n", "x" }, "<leader>fm", function()
        vim.lsp.buf.format({ async = true })
      end, op)
      map({ "n", "x" }, "<leader>ca", function()
        vim.lsp.buf.code_action()
      end, op)
    end,
  })
  --}}}

  -- Fix Treesitter Highlighting {{{
  map("n", "<leader>ts", ":write | edit | TSBufEnable highlight<CR>", opts)
  -- }}}

  -- Remap j and k to gj and gk {{{
  map("n", "j", "gj", opts)
  map("n", "k", "gk", opts)
  -- }}}

  -- Trouble Commands {{{
  map("n", "<leader>xx", function()
    require("trouble").toggle("diagnostics")
  end)
  map("n", "<leader>xq", function()
    require("trouble").toggle("quickfix")
  end)
  map("n", "<leader>xl", function()
    require("trouble").toggle("loclist")
  end)
  -- }}}

  -- TODO Comments {{{
  map("n", "]t", function()
    require("todo-comments").jump_next()
  end, opts)

  map("n", "[t", function()
    require("todo-comments").jump_prev()
  end, opts)
  -- }}}

  -- VimBeGood Commands {{{
  map("n", "<leader>bg", ":VimBeGood<CR>", opts)
  --}}}

  -- Copilot require("CopilotChat") Commands {{{
  map("n", "<leader>cc", function()
    require("CopilotChat").toggle({
      window = {
        layout = "float",
        title = "Copilot Chat",
      },
    })
  end, opts)
  --}}}

  -- Dadbod Commands {{{
  map("n", "<leader>db", ":DBUIToggle<CR>", opts)
  --}}}

  map({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>")
  map({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>")
  map({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>")
  map({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>")
  map({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")

  -- map({ "n", "x" }, "<leader>ca", function()
  --   require("fastaction").code_action()
  -- end, opts)
  aucmd("FileType", {
    pattern = { "sh", "zsh", "bash" },
    callback = function()
      vim.lsp.start({
        name = "bash-language-server",
        cmd = { "bash-language-server", "start" },
      })
    end,
  })

  vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
  aucmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
  })
  -- Ndoo Commands {{{
  map({ "n", "x" }, "<leader>ro", function()
    require("ndoo").open({ v = true })
  end, opts)
  map("n", "<leader>rc", function()
    require("ndoo").open({ commit = true })
  end, opts)
  map("n", "<leader>rC", function()
    require("ndoo").commit()
  end, opts)
  map("n", "<leader>rn", function()
    require("ndoo").repo()
  end, opts)
  map("n", "<leader>rp", function()
    require("ndoo").pulls()
  end, opts)
  map("n", "<leader>ri", function()
    require("ndoo").issues()
  end, opts)
  map("n", "<leader>rl", function()
    require("ndoo").labels()
  end, opts)
  map("n", "<leader>rP", function()
    require("ndoo").pipelines()
  end, opts)
  -- }}}

  -- Neogit commands
  -- map("n", "<leader>gc", function()
  -- require("neogit").open({ "commit" })
  -- end)

  -- Go Impl Commands {{{
  map("n", "<leader>im", function()
    require("telescope").extensions.goimpl.goimpl()
  end)
end

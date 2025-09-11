-- Locals {{{

local map = vim.keymap.set
local bmap = vim.api.nvim_buf_set_keymap
local aucmd = vim.api.nvim_create_autocmd
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true }
---@param description string
---@return { noremap: boolean, silent: boolean, desc: string }
local function desc(description)
  local result = vim.tbl_extend("force", opts, { desc = description })
  return result
end

local count = vim.v.count1

-- Function to handle movement with count
-- local function move_with_count(count1, move_func, ...)
--   for _ = 1, count1 do
--     move_func(...)
--   end
-- end
local function move_block_visual(count2, move_func, ...)
  -- Select the entire block
  vim.cmd("normal! gv")
  -- Move the block for the given count
  for _ = 1, count2 do
    move_func(...)
  end
end

local ok, ToggleTerm = pcall(require, "toggleterm.terminal")
local Terminal = ok and ToggleTerm.Terminal or nil
local lazygit
local lazydots
local dot_dir = "/GitHub/dotfiles"

if Terminal then
  lazygit = Terminal:new {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      bmap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
    end,
    -- function to run on closing the terminal
    on_close = function()
      vim.cmd("startinsert!")
    end,
  }
  lazydots = Terminal:new {
    cmd = "lazygit"
      .. " --git-dir="
      .. vim.fn.expand("$HOME")
      .. dot_dir
      .. " --work-tree="
      .. vim.fn.expand("$HOME"),
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    on_open = function(term)
      vim.cmd("startinsert!")
      bmap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
    end,
    on_close = function()
      vim.cmd("startinsert!")
    end,
  }
end

--}}}

-- {{{ Markmap Commands
map("n", "<leader>mm", "<cmd>MarkmapOpen<CR>", desc("Open Markmap"))
-- }}}

-- Sway config fix {{{
aucmd({ "BufRead", "BufNewFile" }, {
  pattern = vim.fn.expand("~") .. "/.config/sway/conf.d/*"
    or vim.fn.expand("~") .. "/GitHub/OurDots/.config/sway/conf.d/*",
  callback = function()
    vim.bo.filetype = "swayconfig"
  end,
})
-- }}}

-- Fix for HighPhish/rainbow-delimiters.nvim {{{
aucmd("BufReadPost", {
  pattern = "*",
  callback = function(args)
    -- vim.treesitter.get_parser():parse()
    pcall(vim.treesitter.start, args.buf, "")
    vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
-- aucmd("FileType", {
--   pattern = { "<filetype>" },
--   callback = function(args)
--     vim.treesitter.start()
--     vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
--   end,
-- })
-- }}}

-- Move Commands {{{

-- Normal-mode commands {{{
map("n", "<leader>h", function()
  require("move.core.horiz").horzChar(-1)
end, desc("Move Character left"))
map("n", "<leader>j", function()
  require("move.core.vert").moveLine(1, true)
end, desc("Move Line down"))
map("n", "<leader>k", function()
  require("move.core.vert").moveLine(-1, true)
end, desc("Move line up"))
map("n", "<leader>l", function()
  require("move.core.horiz").horzChar(1)
end, desc("Move character right"))
map("n", "<leader>wf", function()
  require("move.core.horiz").horzWord(1)
end, desc("Move word forward"))
map("n", "<leader>wb", function()
  require("move.core.horiz").horzWord(-1)
end, desc("Move word back"))

-- Normal mode mappings with count support
-- vim.keymap.set("n", "<leader>j", function()
--   move_with_count(vim.v.count1, move_vert.moveLine, 1)
-- end, opts)
-- vim.keymap.set("n", "<leader>k", function()
--   move_with_count(vim.v.count1, move_vert.moveLine, -1)
-- end, opts)
-- vim.keymap.set("n", "<leader>l", function()
--   move_with_count(vim.v.count1, move_horiz.horzWord, 1)
-- end, opts)
-- vim.keymap.set("n", "<leader>h", function()
--   move_with_count(vim.v.count1, move_horiz.horzWord, -1)
-- end, opts)

-- Visual mode mappings with block movement
-- }}}

-- Visual-mode commands {{{
vim.keymap.set("v", "<A-j>", function()
  if count == 0 then
    count = 1
  end
  move_block_visual(count, require("move.core.vert").moveBlock, 1)
end, opts)
vim.keymap.set("v", "<A-k>", function()
  if count == 0 then
    count = 1
  end
  move_block_visual(count, require("move.core.vert").moveBlock, -1)
end, opts)
vim.keymap.set("v", "<A-l>", function()
  if count == 0 then
    count = 1
  end
  move_block_visual(count, require("move.core.horiz").horzBlock, 1)
end, opts)
vim.keymap.set("v", "<A-h>", function()
  if count == 0 then
    count = 1
  end
  move_block_visual(count, require("move.core.horiz").horzBlock, -1)
end, opts)
-- }}}

--}}}

-- Fancy Delete word {{{
-- In insert mode
map("i", "<C-h>", "<C-w>", desc("Delete word backward"))
map("i", "<C-BS>", "<C-w>", desc("Delete word backward"))
map("i", "<C-l>", "<C-o>dw", desc("Delete word forward"))
map("i", "<C-Del>", "<C-o>dw", desc("Delete word forward"))

-- In normal mode (if you want them there too)
-- map("n", "<C-h>", "db", desc("Delete word backward"))
-- map("n", "<C-BS>", "db", desc("Delete word backward"))
-- map("n", "<C-l>", "dw", desc("Delete word forward"))
-- map("n", "<C-Del>", "dw", desc("Delete word forward"))
-- }}}

-- Neo Tree Commands {{{
-- map("n", "<C-n>", ":Neotree toggle<cr>", opts)
map("n", "<C-n>", function()
  vim.notify(
    "Keymap depreciated use '-' to toggle Neo-Tree",
    vim.log.levels.WARN,
    { title = "NeoTree" }
  )
end, opts)
map("n", "-s", function()
  require("neo-tree.command").execute {
    source = "git_status",
    -- action = "show",
  }
end, opts)
map("n", "-", function()
  local reveal_file = vim.fn.expand("%:p")
  if reveal_file == "" then
    reveal_file = vim.fn.getcwd()
  else
    local f = io.open(reveal_file, "r")
    if f then
      f.close(f)
    else
      reveal_file = vim.fn.getcwd()
    end
  end
  require("neo-tree.command").execute {
    action = "focus", -- OPTIONAL, this is the default value
    source = "filesystem", -- OPTIONAL, this is the default value
    -- position = "left", -- OPTIONAL, this is the default value
    reveal_file = reveal_file, -- path to file or folder to reveal
    reveal_force_cwd = true, -- change cwd without asking if needed
    toggle = true,
  }
end, desc("Toggle neo-tree at current file or working directory"))
-- }}}

-- LazyGit Commands {{{
map("n", "<leader>gg", function()
  lazygit:toggle()
end, opts)
map("n", "<leader>bl", function()
  lazydots:toggle()
end, opts)
--}}}

-- Ndoo Git Commands {{{
map({ "n", "x" }, "<leader>go", function()
  require("ndoo").open { v = true }
end, desc("Opens GH Web-IDE with current line pre-selected"))
map("n", "<leader>gc", function()
  require("ndoo").open { commit = true }
end, desc("Opens GH Web-IDE at current commit"))
map("n", "<leader>gC", function()
  require("ndoo").commit()
end, desc("Prompts for a commit hash and opens in GH web-view"))
map("n", "<leader>gr", function()
  require("ndoo").repo()
end, desc("Opens base GH page of current git repository"))
map("n", "<leader>gp", function()
  require("ndoo").pulls()
end, desc("Lists all open PRs. Opens web-view of PR selected."))
map("n", "<leader>gi", function()
  require("ndoo").issues()
end, desc("Lists all open issues. Opens web-view of the issue selected."))
map("n", "<leader>gl", function()
  require("ndoo").labels()
end, desc("Lists all labels. Opens web-view of label selected."))
map("n", "<leader>gP", function()
  require("ndoo").pipelines()
end, desc("Opens web-view of GitHub Actions for current git repository"))
-- }}}

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
map({ "n", "t" }, "<A-p>", "<C-\\><C-n><C-w>", opts)
map({ "t" }, "<esc>", "<C-\\><C-n><cmd>q<CR>", opts)
-- }}}

-- Save Quit eXit {{{
map({ "n", "x", "i" }, "<C-s>", "<cmd>w<cr>", opts)
-- map("x", "<C-s>", "<esc> :w | e | TSBufEnable highlight<cr>", opts)
-- map("i", "<C-s>", "<esc> :w | e | TSBufEnable highlight<cr>i", opts)
map({ "n", "t", "x", "i" }, "<C-q>", "<cmd>q!<cr>", opts)
map({ "n", "x" }, "X", "<cmd>x<cr>", opts)
--}}}

-- Esc to clear highlight in normal {{{
map("n", "<esc>", "<cmd>nohlsearch<CR>")
-- }}}

-- Format on Save {{{
-- aucmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })
-- }}}

-- ToggleTerm Commands {{{
map({ "n", "i" }, "<leader>td", function()
  require("toggleterm").exec("prd")
end, opts)
map({ "n", "i" }, "<leader>tt", function()
  require("toggleterm").toggle()
end, opts)
-- map({ "n", "i", "t" }, "<leader>tx", function()
--   require("toggleterm.terminal").Terminal:
-- end, opts)
-- }}}

-- Taskwarrior Commands {{{
map("n", "<leader>tw", function()
  require("taskwarrior_nvim").browser {}
end, opts)
-- }}}

-- Telescope Commands {{{
-- Find File in CWD
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files {
    search_dirs = require("telescope").extensions.frecency.query {
      workspace = "GIT",
    },
  }
end, desc("Find File in CWD with Frecency"))
-- Find File Globally
map("n", "<leader>fF", function()
  require("telescope.builtin").find_files {
    search_dirs = require("telescope").extensions.frecency.query {},
  }
end, desc("Find File Globally with Frecency"))
-- Live Grep in CWD
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep {
    search_dirs = require("telescope").extensions.frecency.query {
      workspace = "CONF",
    },
  }
end, desc("Live Grep in CWD with Frecency"))
-- Live Grep Globally
map("n", "<leader>fG", function()
  require("telescope.builtin").live_grep {
    search_dirs = require("telescope").extensions.frecency.query {},
  }
end, desc("Live Grep Globally with Frecency"))
map("n", "<leader>fgg", function()
  require("telescope").extensions.lazygit.lazygit {}
end, desc("Open LazyGit in Telescope"))
map("n", "<leader>fgf", function()
  require("telescope.builtin").git_files {}
end, desc("Find Git Files"))
map("n", "<leader>fgb", function()
  require("telescope.builtin").git_branches {}
end, desc("Git Branches"))
map("n", "<leader>fgC", function()
  require("telescope.builtin").git_bcommits {}
end, desc("Git Buffer Commits"))
map("n", "<leader>fgs", function()
  require("telescope.builtin").git_stash {}
end, desc("Git Stash"))
map("n", "<leader>fgc", function()
  require("telescope").extensions.conflicts.conflicts {}
end, desc("Git Conflicts"))
map("n", "<leader>fgi", function()
  require("telescope").extensions.gh.issues {}
end, desc("GitHub Issues"))
map("n", "<leader>fgp", function()
  require("telescope").extensions.gh.pull_request {}
end, desc("GitHub Pull Requests"))
map("n", "<leader>fgG", function()
  require("telescope").extensions.gh.gist {}
end, desc("GitHub Gists"))
map("n", "<leader>fgr", function()
  require("telescope").extensions.gh.run {}
end, desc("GitHub Run"))
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers {}
end, desc("Buffers"))
map("n", "<leader>fB", function()
  require("telescope.builtin").current_buffer_fuzzy_find {}
end, desc("Current Buffer Fuzzy Find"))
map("n", "<leader>fk", function()
  require("telescope.builtin").keymaps {}
end, desc("Keymaps"))
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags {}
end, desc("Help Tags"))
map("n", "<leader>fH", function()
  require("telescope.builtin").highlights {}
end, desc("Highlights"))
map("n", "<leader>fd", function()
  require("telescope.builtin").lsp_definitions {}
end, desc("LSP Definitions"))
map("n", "<leader>ft", function()
  require("telescope.builtin").lsp_type_definitions {}
end, desc("LSP Type Definitions"))
map("n", "<leader>fr", function()
  require("telescope.builtin").lsp_references {}
end, desc("LSP References"))
map("n", "<leader>fD", function()
  require("telescope.builtin").diagnostics {}
end, desc("LSP Diagnostics"))
map("n", "<leader>fq", function()
  require("telescope.builtin").quickfix {}
end, desc("Quickfix List"))
map("n", "<leader>fQ", function()
  require("telescope.builtin").quickfixhistory {}
end, desc("Quickfix History"))
map("n", "<leader>fi", function()
  require("telescope.builtin").lsp_implementations {}
end, desc("LSP Implementations"))
map("n", "<leader>fvo", function()
  require("telescope.builtin").vim_options {}
end, desc("Vim Options"))
map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_document_symbols {}
end, desc("LSP Document Symbols"))
map("n", "<leader>fy", function()
  require("telescope").extensions.neoclip.default {}
end, desc("Neoclip Clipboard Manager"))
map("n", "<leader>fu", function()
  require("telescope").extensions.undo.undo {}
end, desc("Undo History"))
map("n", "<leader>fm", function()
  require("telescope").extensions.messages.messages {}
end, desc("Neovim Messages"))
map("n", "<leader>fms", function()
  require("telescope").extensions.macroscope.default {}
end, desc("Macroscope Search"))
map("n", "<leader><leader>", function()
  require("telescope").extensions.frecency.frecency {}
end, desc("Frecency"))
map("n", "<leader>fl", function()
  require("telescope").extensions["licenses-nvim"].insert()
end, desc("Insert License"))
map("n", "<leader>fL", function()
  require("licenses").write_license(
    "LICENSE",
    require("licenses").get_config(vim.api.nvim_get_current_buf())
  )
end, desc("Write License to LICENSE file"))
map("n", "<leader>fT", function()
  require("telescope").extensions["todo-comments"].todo {}
end, desc("Todo Comments"))
map("n", "<leader>fN", function()
  require("telescope").extensions.nerdy.nerdy {}
end, desc("Nerd Fonts"))
map("n", "<leader>Fp", function()
  require("telescope").extensions.pathogen.pathogen {}
end, desc("File browser with Pathogen"))
map("n", "<leader>Fg", function()
  require("telescope").extensions.pathogen.live_grep {}
end, desc("Live Grep with Pathogen"))
map("n", "<leader>Fs", function()
  require("telescope").extensions.pathogen.grep_string {}
end, desc("Grep String with Pathogen"))
map("n", "<leader>Ff", function()
  require("telescope").extensions.pathogen.find_files {}
end, desc("Find Files with Pathogen"))
map("n", "<leader>fp", function()
  require("telescope").extensions.lazy_plugins.lazy_plugins {}
end, desc("Lazy Plugins"))
map("n", "<leader>fP", function()
  require("telescope").extensions.lazy.lazy {}
end, desc("Lazy"))
map("n", "<leader>fn", function()
  require("telescope").extensions.notify.notify {}
end, desc("Notifications"))
--}}}

-- License Commands {{{
-- map("n", "cil", function()
-- require("licenses").insert(bufnr, 0, require("licenses").get_config(bufnr))
-- end, opts)
-- }}}

-- Nvim Space Folding {{{
map("n", "<Space>", "@=(foldlevel('.')?'za':'\\<Space>')<CR>", opts)
map("x", "<Space>", "zf", opts)
-- }}}

-- Close Current Buffer {{{
map("n", "<leader>bd", "<cmd>bd<cr>", opts)
map({ "x", "i" }, "<leader>bd", "<esc> <cmd>bd<cr>", opts)
-- }}}

-- Move to Previous and Next Buffer {{{
map("n", "<C-H>", "<cmd>bprev<CR>", opts)
-- map({ "x", "i" }, "<C-h>", "<esc> <cmd>bprev<cr>", opts)

map("n", "<C-L>", "<cmd>bnext<CR>", opts)
-- map({ "x", "i" }, "<C-l>", "<esc> <cmd>bnext<cr>", opts)
-- }}}

-- Run Eslint with Leader lf {{{
map("n", "<leader>lf", function()
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  }
end, opts)
-- }}}

-- Diagnostic Window on CursorHold {{{
aucmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float {
      scope = "cursor",
      border = "rounded",
      source = "if_many",
      focusable = false,
    }
  end,
})
--}}}

-- Hover Commands {{{
map("n", "K", function()
  require("hover").open {}
end, desc("hover.nvim"))
map("n", "gK", function()
  require("hover").select {}
end, desc("hover.nvim (select)"))
map("n", "<C-p>", function()
  require("hover").switch("previous")
end, desc("hover.nvim (previous source)"))
map("n", "<C-n>", function()
  require("hover").switch("next")
end, desc("hover.nvim (next source)"))

-- Mouse support
map("n", "<MouseMove>", function()
  require("hover").mouse()
end, desc("hover.nvim (mouse)"))
-- }}}

-- Notify Mason Update {{{
aucmd("User", {
  pattern = "MasonToolsUpdateCompleted",
  callback = function(e)
    vim.schedule(function()
      if #e.data == 0 then
        vim.notify(
          "All LSP servers are up-to-date!",
          vim.log.levels.INFO,
          { title = "mason-tool-installer" }
        )
      end
      require("apeoplescalendar").today_teaser()
    end)
  end,
})

aucmd("User", {
  pattern = "MasonHarmonyUpdateCompleted",
  callback = function(e)
    vim.schedule(function()
      if #e.data == 0 then
        vim.notify(
          "All LSP servers are up-to-date!",
          vim.log.levels.INFO,
          { title = "mason-harmony" }
        )
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
map("n", "<leader>bp", function()
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
map("n", "<leader>dt", function()
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
      require("goto-preview").goto_preview_definition {}
    end, op)

    map("n", "gD", function()
      require("goto-preview").goto_preview_declaration {}
    end, op)

    map("n", "gi", function()
      require("goto-preview").goto_preview_implementation {}
    end, op)

    map("n", "gh", function()
      require("inlay-hints.utils").toggle_inlay_hints()
    end, op)

    map("n", "gt", function()
      require("goto-preview").goto_preview_type_definition {}
    end, op)

    map("n", "gr", function()
      require("goto-preview").goto_preview_references {}
    end, op)

    map("n", "[d", function()
      if vim.tbl_isempty(vim.diagnostic.get(0)) then
        require("trouble").close("diagnostics")
        vim.notify(
          "No diagnostic errors found",
          vim.log.levels.INFO,
          { title = "Trouble" }
        )
      else
        vim.diagnostic.jump { count = -1 }
        require("trouble").open("diagnostics")
      end
    end, op)

    map("n", "]d", function()
      if vim.tbl_isempty(vim.diagnostic.get(0)) then
        require("trouble").close("diagnostics")
        vim.notify(
          "No diagnostic errors found",
          vim.log.levels.INFO,
          { title = "Trouble" }
        )
      else
        vim.diagnostic.jump { count = 1 }
        require("trouble").open("diagnostics")
      end
    end, op)
    -- map("n", "K", function()
    --   vim.lsp.buf.hover()
    -- end, op)
    map("n", "gs", function()
      vim.lsp.buf.signature_help()
    end, op)
    map("n", "gS", function()
      -- use telescope to show all symbols
      require("telescope.builtin").lsp_document_symbols()
    end, op)
    map("n", "<leader>rn", function()
      local input = vim.fn.input("New Name")
      if input ~= "" then
        vim.cmd("IncRename " .. input)
      end
    end, op)
    -- Format and Code Actions
    map({ "n", "x" }, "<leader>fm", function()
      vim.lsp.buf.format { async = true }
    end, op)
    map({ "n", "x" }, "<leader>ca", function()
      require("fastaction").code_action()
    end, op)
  end,
})
--}}}

-- Dial Commands {{{
vim.keymap.set("n", "<C-a>", function()
  require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
  require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
  require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
  require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("x", "<C-a>", function()
  require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("x", "<C-x>", function()
  require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("x", "g<C-a>", function()
  require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("x", "g<C-x>", function()
  require("dial.map").manipulate("decrement", "gvisual")
end)
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

-- Copilot Commands {{{
map("n", "<leader>cc", function()
  require("CopilotChat").toggle {
    window = {
      layout = "float",
    },
  }
end)
--}}}

-- TGPT Commands {{{
map("n", "<leader>tc", "<cmd>Chat<cr>", opts)
map("n", "<leader>tr", "<cmd>RateMyCode<cr>", opts)
-- }}}

-- Dadbod Commands {{{
map("n", "<leader>db", ":DBUIToggle<CR>", opts)
--}}}

-- Navigator Commands {{{
if os.getenv("TMUX") ~= nil or os.getenv("WEZTERM") then
  map({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>", opts)
  map({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>", opts)
  map({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>", opts)
  map({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>", opts)
  map({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>", opts)
end
-- }}}

-- Lualine LSP Progress {{{
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
aucmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = vim.schedule_wrap(function()
    local timer = nil
    if timer then
      timer:stop()
    end
    timer = vim.uv.new_timer()
    if timer then
      timer:start(
        100,
        0,
        vim.schedule_wrap(function()
          require("lualine").refresh()
        end)
      )
    end
  end),
})
-- }}}

-- New File Commands {{{
map("n", "<leader>e", function()
  -- Prompt the user for the new file name
  local new_file_name = vim.fn.input("New file name: ")
  if new_file_name ~= "" then
    -- Open the new file
    vim.cmd("edit " .. new_file_name)
  end
end, opts)
-- }}}

-- Terminal Commands {{{
map("n", "<leader>T", function()
  -- Prompt the user for the new terminal command
  local new_term_cmd = vim.fn.input("Terminal command: ")
  if new_term_cmd ~= "" then
    -- Open the new terminal
    vim.cmd("!" .. new_term_cmd)
  end
end, opts)
--}}}

-- Disable Notifications on InsertEnter {{{
aucmd({ "InsertEnter" }, {
  group = vim.api.nvim_create_augroup("NotifyClearGrp", {}),
  pattern = "*",
  callback = function()
    require("notify").dismiss { silent = true, pending = true }
  end,
})
-- }}}

-- Go Impl Commands {{{
map("n", "<leader>im", function()
  require("telescope").extensions.goimpl.goimpl()
end)
--}}}

-- Better Paste {{{
map("i", "<C-p>", '<Esc>"_ddP`]a<CR>', opts)

-- function SmartPaste()
--   local termux_content = ""
--
--   if vim.fn.executable("termux-clipboard-get") == 1 then
--     local result = vim.fn.system("termux-clipboard-get")
--     if vim.v.shell_error == 0 then
--       termux_content = result:gsub("\n$", "")
--     end
--   end
--
--   local unnamed_content = vim.fn.getreg('"')
--
--   -- Always prefer termux if it has content and is different
--   if termux_content ~= "" and termux_content ~= unnamed_content then
--     vim.fn.setreg('"', termux_content)
--     vim.cmd("normal! p")
--     vim.notify(
--       "📋 Pasted from termux (different content)" .. termux_content,
--       vim.log.levels.INFO
--     )
--   else
--     vim.cmd("normal! p")
--     vim.notify("📝 Pasted from unnamed register", vim.log.levels.INFO)
--   end
-- end
-- map("n", "p", SmartPaste, opts)
-- }}}

-- Better Delete, Cut, Select {{{
map({ "n", "v" }, "yd", "d", desc("Save and delete text"))
map({ "n", "v" }, "d", '"_d', desc("Send deleted text to Black Hole Reg"))
map({ "n", "v" }, "D", '"_D', desc("Send deleted text to Black Hole Reg"))
map({ "n", "v" }, "c", '"_c', desc("Send cut text to Black Hole Reg"))
map({ "n", "v" }, "C", '"_C', desc("Send cut text to Black Hole Reg"))
map({ "n", "v" }, "s", '"_s', desc("Send substituted text to Black Hole Reg"))
-- }}}

-- Auto Save {{{
local save_timer = nil
local delay_time = 5000
aucmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if save_timer then
      vim.fn.timer_stop(save_timer)
      save_timer = nil
    end

    -- Start new timer
    save_timer = vim.fn.timer_start(delay_time, function()
      local excluded_modes = { "c", "i", "t", "r", "R", "x", "v" }
      if
        vim.bo.modified
        and not vim.tbl_contains(excluded_modes, vim.fn.mode())
      then
        vim.cmd("update")
      end
      save_timer = nil -- Clear the timer reference after execution
    end)
  end,
  desc = "Auto Save on InsertLeave and/or TextChanged",
})
-- }}}

-- Bacon-ls Fix {{{
aucmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    os.execute("pkill bacon-ls")
  end,
})
-- }}}

-- Cargo Build on Save {{{
vim.api.nvim_create_autocmd("BufWritePost", {
  -- cargo build on saving any file within src directory of a cargo project
  pattern = "*/src/*.rs" or "*/tests/*.rs" or "*/examples/*.rs",
  callback = function()
    -- Find the Cargo.toml directory
    local cargo_root = vim.fn.findfile("Cargo.toml", ".;")
    if cargo_root == "" then
      vim.notify("Cargo.toml not found!", vim.log.levels.WARN, {
        title = "Cargo Build",
      })
      return
    end

    local project_dir = vim.fn.fnamemodify(cargo_root, ":h")

    vim.notify("Building Cargo Project...", vim.log.levels.INFO, {
      title = "Cargo Build",
    })

    vim.fn.jobstart({ "cargo", "build" }, {
      cwd = project_dir,
      on_exit = function(_, exit_code, _)
        if exit_code == 0 then
          vim.schedule(function()
            vim.notify("Cargo Build Succeeded!", vim.log.levels.INFO, {
              title = "Cargo Build",
            })
          end)
        else
          vim.schedule(function()
            vim.notify("Cargo Build Failed!", vim.log.levels.ERROR, {
              title = "Cargo Build",
            })
          end)
        end
      end,
    })
  end,
})

-- Toggle Backup {{{
map("n", "<leader>tb", function()
  -- Get current backup status
  local backup_enabled = vim.o.backup

  -- Toggle backup option for current buffer
  vim.o.backup = not backup_enabled
  vim.o.writebackup = not backup_enabled

  -- Show message about new state
  if not backup_enabled then
    print("Backup enabled for current buffer")
  else
    print("Backup disabled for current buffer")
  end
end, { desc = "Toggle backup for current buffer" })
-- }}}

-- Help Docs Navigation {{{
aucmd("FileType", {
  pattern = "help",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<C-o>", "<C-]>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<C-p>", "<C-O>", opts)
  end,
})
-- }}}

-- Add punctuation to end of line {{{
map("n", "..", "mzA.<Esc>`z", desc("add period to end of line"))
map("n", ",,", "mzA,<Esc>`z", desc("add comma to end of line"))
map("n", ";;", "mzA;<Esc>`z", desc("add semicolon to end of line"))
map("n", "!!", "mzA!<Esc>`z", desc("add exclamation point to end of line"))
map("n", "??", "mzA!<Esc>`z", desc("add question mark to end of line"))
-- }}}

-- APeoplesCalandar Event {{{
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() end,
})
-- }}}

-- vim modeline {{{
-- vim:fdm=marker
-- }}}

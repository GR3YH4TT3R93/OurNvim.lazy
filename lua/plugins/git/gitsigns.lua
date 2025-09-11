---@class LazyPlugin
return {
  "lewis6991/gitsigns.nvim",
  event = { "VeryLazy" },
  ---@module "gitsigns"
  ---@class Gitsigns.Config
  opts = {
    -- Gitsigns in dotfiles!
    worktrees = {
      {
        toplevel = vim.env.HOME,
        gitdir = vim.env.HOME .. "/Projects/dotfiles", -- NOTE: This is a bare .git directory
      },
    },
    numhl = true,
    linehl = false,
    -- word_diff = true,
    -- sign_priority = 100,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
    preview_config = {
      border = "rounded",
    },
    on_attach = function(bufnr)
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      local gs = require("gitsigns")
      -- Navigation
      map({ "n", "o", "x" }, "]h", function()
        if vim.wo.diff then
          vim.cmd.normal { "]h", bang = true }
        else
          gs.nav_hunk("next")
        end
      end)

      map({ "n", "o", "x" }, "[h", function()
        if vim.wo.diff then
          vim.cmd.normal { "[h", bang = true }
        else
          gs.nav_hunk("prev")
        end
      end)

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk)
      map("n", "<leader>hr", gs.reset_hunk)
      map("v", "<leader>hs", function()
        gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
      end)
      map("v", "<leader>hr", function()
        gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
      end)
      map("n", "<leader>hS", gs.stage_buffer)
      map("n", "<leader>hR", gs.reset_buffer)
      map("n", "<leader>hp", gs.preview_hunk)
      map("n", "<leader>hb", gs.toggle_current_line_blame)
      map("n", "<leader>hd", gs.diffthis)
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end)
      map("n", "<leader>hQ", function()
        gs.setqflist("all")
      end)
      map("n", "<leader>hq", gs.setqflist)
      map("n", "<leader>tD", gs.preview_hunk_inline)
      map("n", "<leader>ti", gs.preview_hunk_inline)
      map("n", "<leader>tw", gs.toggle_word_diff)

      -- Text object
      map({ "o", "x" }, "ih", gs.select_hunk)
    end,
  },
}

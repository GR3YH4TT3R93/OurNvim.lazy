return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    -- search = {
    --   mode = "fuzzy",
    -- },
    jump = {
      autojump = true,
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = true,
        search = {
          wrap = true,
        },
        highlight = {
          backdrop = false,
        },
      },
    },
    prompt = {
      enabled = false,
    },
    remote_op = {
      restore = true,
      motion = nil,
    },
  },
  -- stylua: ignore
  keys = {
    { "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash"
    },
    {
      "sd",
      mode = { "n", "x", "o" },
      function ()
        require("flash").jump({
          ---@param win integer
          matcher = function(win)
            return vim.tbl_map(function(diag)
              return {
                pos = { diag.lnum + 1, diag.col },
                end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
              }
            end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
          end,
          action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
              vim.api.nvim_win_set_cursor(match.win, match.pos)
              vim.diagnostic.open_float({ border = "rounded" })
            end)
            state:restore()
          end,
        })
      end
    },
    { "st",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter"
    },
    { "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash"
    },
    { "R",
       mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search"
    },
    { "<c-s>",
      mode = { "c" },
      function() require("flash").toggle()
      end, desc = "Toggle flash Search"
    },
  },
}

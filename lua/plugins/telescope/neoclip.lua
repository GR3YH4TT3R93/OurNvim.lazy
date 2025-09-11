---@class LazyPlugin
return {
  "AckslD/nvim-neoclip.lua",
  event = { "VeryLazy" },
  dependencies = { "kkharji/sqlite.lua" },
  ---@module "neoclip"
  opts = {
    history = 1000,
    enable_persistent_history = true,
    length_limit = 1048576,
    continuous_sync = false,
    db_path = vim.fn.stdpath("data") .. "/neoclip.sqlite3",
    filter = function(data)
      local function is_whitespace(line)
        return vim.fn.match(line, [[^\s*$]]) ~= -1
      end

      local function all(tbl, check)
        for _, entry in ipairs(tbl) do
          if not check(entry) then
            return false
          end
        end
        return true
      end
      return not all(data.event.regcontents, is_whitespace)
    end,
    preview = true,
    prompt = nil,
    default_register = { "+", '"', "*" },
    default_register_macros = "q",
    enable_macro_history = true,
    content_spec_column = false,
    disable_keycodes_parsing = false,
    on_select = {
      move_to_front = true,
      close_telescope = true,
    },
    on_paste = {
      set_reg = false,
      move_to_front = true,
      close_telescope = true,
    },
    on_replay = {
      set_reg = false,
      move_to_front = true,
      close_telescope = true,
    },
    on_custom_action = {
      close_telescope = true,
    },
    keys = {
      telescope = {
        i = {
          select = "<cr>",
          paste = { "<c-p>", "<cr>" },
          paste_behind = "<c-k>",
          replay = "<c-r>", -- replay a macro
          delete = "<c-d>", -- delete an entry
          edit = "<c-e>", -- edit an entry
          custom = {},
        },
        n = {
          select = "<cr>",
          --- It is possible to map to more than one key.
          paste = { "p", "<c-p>", "<cr>" },
          paste_behind = "P",
          replay = "r",
          delete = "d",
          edit = "e",
          custom = {},
        },
      },
      fzf = {
        select = "default",
        paste = { "<c-p>", "<cr>" },
        paste_behind = "<c-k>",
        custom = {},
      },
    },
  },
}

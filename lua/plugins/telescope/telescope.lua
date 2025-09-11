---@class LazyPlugin
return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-github.nvim",
    "tsakirist/telescope-lazy.nvim",
    -- "nvim-telescope/telescope-frecency.nvim",
    -- "nvim-telescope/telescope-fzf-native.nvim",
    -- "d4wns-l1ght/telescope-messages.nvim",
    -- "AckslD/nvim-neoclip.lua",
    -- "brookhong/telescope-pathogen.nvim",
    -- "nvim-telescope/telescope-ui-select.nvim",
    -- "debugloop/telescope-undo.nvim",
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = "󱞩 ",
      path_display = { "filename_first" },
      layout_strategy = "vertical",
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close,
          ["<CR>"] = function(prompt_bufnr)
            local actions = require("telescope.actions")
            local selection =
              require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            actions.select_default(prompt_bufnr)
            vim.cmd("silent cd" .. dir)
          end,
        },
      },
    },
    extensions = {
      ["fzf"] = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {},
      },
      ["licenses-nvim"] = { default_action = "insert" },
      ["pathogen"] = {
        attach_mappings = function(map, actions)
          map("i", "<C-h>", actions.proceed_with_parent_dir)
          map("i", "<C-l>", actions.revert_back_last_dir)
          map("i", "<C-b>", actions.change_working_directory)
          map("i", "<C-g>g", actions.grep_in_result)
          map("i", "<C-g>i", actions.invert_grep_in_result)
        end,
        -- remove below if you want to enable it
        use_last_search_for_live_grep = false,
        quick_buffer_characters = "asdfgqwertzxcvb",
        prompt_prefix_length = 100,
        relative_prompt_path = true,
        prompt_suffix = "  ",
      },
      ["lazy"] = {},
      ---@module "telescope._extensions.lazy_plugins"
      ---@type TelescopeLazyPluginsUserConfig
      ["lazy_plugins"] = {
        lazy_config = vim.fn.stdpath("config") .. "/init.lua", -- Must be a valid path to the file containing the lazy spec and setup() call.
        picker_opts = {
          sorting_strategy = "descending",
          layout_strategy = "flex",
        },
      },
      -- ["taskwarrior"]
      ["undo"] = {},
      ---@module "frecency"
      ---@class FrecencyOpts
      ["frecency"] = {
        show_filter_column = false,
        db_version = "v2",
        matcher = "fuzzy",
        auto_validate = true,
        db_safe_mode = false,
        prompt_title = "Frecency",
        enable_prompt_mappings = true,
        hide_current_buffer = true,
        bootstrap = true,
        show_scores = false,
        default_workspace = "GIT",
        workspaces = {
          ["GIT"] = vim.fn
            .system("git rev-parse --show-toplevel")
            :gsub("\n", ""),
          ["CONF"] = "~/.config/nvim",
        },
      },
    },
  },
}

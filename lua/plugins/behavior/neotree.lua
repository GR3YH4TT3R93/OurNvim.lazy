---@class LazyPlugin
return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = { "Neotree" },
  -- event = "VeryLazy",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup {
          filter_rules = {
            include_current_win = true,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        }
      end,
    },
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  ---@module 'neo-tree.defaults'
  ---@class neotree.Config
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 1,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "󰉋",
        folder_open = "󰝰",
        folder_empty = "",
        folder_empty_open = "󰷏",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "✖", -- this can only be used in the git_status source
          renamed = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "󱪘",
          ignored = "",
          unstaged = "󱪗",
          staged = "󱪝",
          conflict = "󱪟",
        },
      },
      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
      file_size = {
        enabled = true,
        required_width = 20, -- min width of window required to show this column
      },
      type = {
        enabled = true,
        required_width = 122, -- min width of window required to show this column
      },
      last_modified = {
        enabled = true,
        required_width = 88, -- min width of window required to show this column
        -- format = "",
      },
      created = {
        enabled = true,
        required_width = 110, -- min width of window required to show this column
        -- format = "",
      },
      symlink_target = {
        enabled = true,
      },
    },
    -- A list of functions, each representing a global custom command
    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    -- see `:h neo-tree-custom-commands-global`
    commands = {},
    window = {
      position = "float", -- "float" | "left" | "right" | "top" | "bottom"
      width = 30,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["l"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<space>"] = "open",
        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        -- Read `# Preview Mode` for more information
        ["f"] = "focus_preview",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["S"] = "split_with_window_picker",
        ["V"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        ["<s-cr>"] = "open_drop",
        ["T"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        ["P"] = { "toggle_preview", config = { use_float = true } }, -- enter preview mode, which shows the current node without focusing
        ["x"] = "close_node",
        ["X"] = "close_all_subnodes",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
        ["r"] = "rename",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["[["] = "prev_source",
        ["]]"] = "next_source",
      },
    },
    nesting_rules = {
      ["nuxt.config.*"] = {
        pattern = "^nuxt%.config%..*$", -- Match nuxt.config.*
        files = { "*.config.*", "tsconfig.json", ".prettierignore" }, -- Match all *.config.* files
      },
      ["README"] = {
        pattern = "^README.*$", -- Match README
        ignore_case = true,
        files = { "README.md", "README.txt", "README.rst", "LICENSE" }, -- Match all README files
      },
      ["package.json"] = {
        pattern = "^package%.json$", -- <-- Lua pattern
        files = { "package-lock.json", "yarn*", "pnpm-lock.yaml", ".npmrc" }, -- <-- glob pattern
      },
      ["go"] = {
        pattern = "(.*)%.go$", -- <-- Lua pattern with capture
        files = { "*_test.go", "go.mod", "go.sum" }, -- <-- glob pattern with capture
      },
      ["js-extended"] = {
        pattern = "(.+)%.js$",
        files = { "%1.js.map", "%1.min.js", "%1.d.ts" },
      },
      ["docker"] = {
        pattern = "^dockerfile$",
        ignore_case = true,
        files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ["h"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          -- ["d"] = "fuzzy_sorter_directory",
          ["d"] = "delete",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["y"] = "copy_to_clipboard",
          ["C"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
          -- ["c"] = {
          --  "copy",
          --  config = {
          --    show_path = "none" -- "none", "relative", "absolute"
          --  }
          --}
          ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
          ["i"] = "show_file_details",
          ["a"] = {
            "add",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ["o"] = {
            "show_help",
            nowait = false,
            config = { title = "Order by", prefix_key = "o" },
          },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["og"] = { "order_by_git_status", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
          ["ga"] = "git_add_file",
          ["gA"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<C-f>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
          ["<C-b>"] = "move_cursor_up",
        },
      },

      commands = {}, -- Add a custom command or override a global one using the same function name
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = false,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["o"] = {
            "show_help",
            nowait = false,
            config = { title = "Order by", prefix_key = "o" },
          },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["o"] = {
            "show_help",
            nowait = false,
            config = { title = "Order by", prefix_key = "o" },
          },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
    document_symbols = {
      window = {
        mappings = {
          ["o"] = "jump_to_symbol",
          ["r"] = "rename",
          ["P"] = "preview",
          -- ["s"] = "split",
        },
      },
    },
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
      winbar = true,
      statusline = false,
      show_scrolled_off_parent_node = true,
      sources = {
        {
          source = "filesystem", -- string
          display_name = " 󰉓 Files ", -- string | nil
        },
        {
          source = "buffers", -- string
          display_name = " 󰈚 Buffers ", -- string | nil
        },
        {
          source = "git_status", -- string
          display_name = " 󰊢 Git ", -- string | nil
        },
        {
          source = "document_symbols",
          display_name = "  Symbols ",
        },
      },
      highlight_tab = "Normal",
      highlight_tab_active = "CursorLine",
      highlight_background = "Normal",
      highlight_separator = "Normal",
      highlight_separator_active = "CursorLine",
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute { action = "close" }
        end,
      },
    },
  },
}

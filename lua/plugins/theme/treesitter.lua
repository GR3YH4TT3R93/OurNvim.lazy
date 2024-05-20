return {
  "nvim-treesitter/nvim-treesitter",
  -- tag = "v0.9.2",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",
  },
  config = function()
    local configs = require("nvim-treesitter.configs")
    require("Comment").setup()
    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "vue",
        "typescript",
        "html",
        "css",
        "markdown",
        "json",
        "jsonc",
        "bash",
        "go",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "regex",
        "diff",
        "markdown_inline",
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
      modules = {},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss",
          node_incremental = "<leader>nn",
          node_decremental = "<leader>np",
          scope_incremental = "<leader>sn",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    }) -- Remove the trailing comma here
  end,
  build = ":TSUpdate",
}

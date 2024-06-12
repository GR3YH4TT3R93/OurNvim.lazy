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
        "javascript",
        "html",
        "css",
        "json",
        "jsonc",
        "bash",
        "go",
        "gomod",
        "gosum",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "git_config",
        "regex",
        "diff",
        "markdown",
        "markdown_inline",
        "toml",
        "yaml",
        "properties",
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
    vim.treesitter.language.register("bash", "zsh")
  end,
  build = ":TSUpdate",
}

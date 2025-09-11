---@class LazyPlugin
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TS update",
  branch = "main",
  init = function()
    require("vim.treesitter.query").add_predicate(
      "is-mise?",
      function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ":t")
        return string.match(filename, ".*mise.*%.toml$") ~= nil
      end,
      { force = true, all = false }
    )
    vim.g.loaded_nvim_treesitter = 1
  end,
  event = { "VimEnter" },
  -- lazy = false,
  ---@module "nvim-treesitter.config"
  ---@class TSConfig
  opts = {
    install_dir = vim.fn.stdpath("data") .. "/tree-sitter",
  },
}

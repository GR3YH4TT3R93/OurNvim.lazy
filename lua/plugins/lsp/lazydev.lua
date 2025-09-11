---@class LazyPlugin
return {
  "folke/lazydev.nvim",
  -- dev = true,
  ft = { "lua" },
  dependencies = {
    "DrKJeff16/wezterm-types",
  },
  ---@module "lazydev"
  ---@class lazydev.Config
  opts = {
    library = {
      {
        "lazy.nvim",
        words = { "vim%.*" },
      },
      {
        path = "${3rd}/luv/library",
        words = { "vim%.uv" },
      },
      { path = "wezterm-types", mods = { "wezterm" } },
      {
        path = "${3rd}/luaassert/library",
        words = { "assert" },
      },
      { path = "${3rd}/busted/library", files = { "test.lua" } },
      { "nvim-dap-ui" },
    },
    -- enabled = function(root_dir)
    --   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    -- end,
  },
}

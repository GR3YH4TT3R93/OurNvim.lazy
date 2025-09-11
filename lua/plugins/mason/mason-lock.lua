return {
  "zapling/mason-lock.nvim",
  dependencies = {
    "mason-org/mason.nvim",
  },
  opts = {
    lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json", -- (default)
  },
}

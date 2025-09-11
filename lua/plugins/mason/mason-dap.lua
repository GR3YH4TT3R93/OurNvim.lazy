return {
  "jay-babu/mason-nvim-dap.nvim",
  event = { "BufEnter" },
  -- lazy = false,
  dependencies = {
    "mason-org/mason.nvim",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    -- require("mason").setup()
    require("mason-nvim-dap").setup({
      ensure_installed = {},
      automatic_installation = true,
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })

    require("dapui").setup()
  end,
}

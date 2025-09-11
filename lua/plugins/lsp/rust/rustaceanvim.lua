---@class LazyPlugin
return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  -- lazy = false, -- This plugin is already lazy
  ft = { "rust" },
  ---@module "rustaceanvim"
  ---@type function|rustaceanvim.Opts
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("blink.cmp").get_lsp_capabilities({}, false)
    )
    ---@class rustaceanvim.Opts
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      dap = {
        autoload_configurations = true,
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            capabilities = capabilities,
            completion = {
              fullFunctionSignatures = {
                enable = true,
              },
              hideDepreciated = true,
            },
            diagnostics = {
              enable = false,
              styleLints = {
                enable = false,
              },
            },
            checkOnSave = {
              enable = false,
            },
            hover = {
              actions = {
                references = {
                  enable = true,
                },
              },
              memoryLayout = {
                niches = true,
              },
            },
            -- inlayHints = {
            --   bindingModeHints = {
            --     enable = true,
            --   },
            --   chainingHints = {
            --     enable = true,
            --   },
            --   closingBraceHints = {
            --     enable = true,
            --     minLines = 25,
            --   },
            --   closureCaptureHints = {
            --     enable = true,
            --   },
            --   closureReturnTypeHints = {
            --     enable = "always",
            --   },
            --   expressionAdjustmentHints = {
            --     enable = "always",
            --   },
            --   lifetimeElisionHints = {
            --     enable = "always",
            --     useParameterNames = true,
            --   },
            --   maxLength = 25,
            --   parameterHints = {
            --     enable = true,
            --   },
            --   reborrowHints = {
            --     enable = "always",
            --   },
            --   renderColons = true,
            --   typeHints = {
            --     enable = true,
            --     hideClosureInitialization = true,
            --     hideNamedConstructor = true,
            --   },
            -- },
          },
        },
      },
    }
  end,
}

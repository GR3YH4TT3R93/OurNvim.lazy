return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "github/copilot.vim" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    debug = false, -- Enable debugging
    window = {
      layout = "float",
      border = "rounded",
    },
    system_prompt = "",
    -- See Configuration section for rest
  },
  -- See Commands section for default commands if you want to lazy load on them
}

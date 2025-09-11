---@class LazyPlugin
return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- commit = "ea3678daff66656a9e1c20914d204b7c841c5030",
  ft = { "markdown" },
  opts = {
    heading = {
      position = "overlay", -- "inline" | "overlay"
      width = "full", -- "block" | "full"
    },
    code = {
      width = "block", -- "block" | "full"
      left_pad = 2,
      right_pad = 2,
      -- min_width = 30,
    },
  },
}

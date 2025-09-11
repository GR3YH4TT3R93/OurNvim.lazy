---@type LazyPlugin
return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  ---@module "transparent"
  opts = {
    extra_groups = {
      "LazyNormal",
      "LazyProp",
      "LazyDimmed",
      "TabLineFill",
      "FloatBorder",
      "NormalFloat",
      "EndOfBuffer",
      "NeoTreeFloatBorder",
      "BlinkCmpMenu",
      "BlinkCmpMenuBorder",
      "BlinkCmpDocCursorLine",
      "HoverFloatingInfo",
      "RenderMarkdownCode",
    },
  },
}

return {
  "js-everts/cmp-tailwind-colors",
  config = function()
    require("cmp-tailwind-colors").setup({
      enable_alpha = true, -- requires pumblend > 0.

      format = function(itemColor)
        return {
          fg = itemColor,
          bg = nil, -- or nil if you dont want a background color
          text = "", -- or use an icon
        }
      end,
    })
  end,
}

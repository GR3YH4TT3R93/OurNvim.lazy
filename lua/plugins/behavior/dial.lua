---@class LazyPlugin
return {
  "monaqa/dial.nvim",
  event = { "CursorMoved" },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.constant.alias.ja_weekday_full,
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.misc.alias.markdown_header,
        -- augend.paren.alias.brackets,
        augend.paren.alias.quote,
        augend.paren.alias.lua_str_literal,
        augend.paren.alias.rust_str_literal,
        augend.date.alias["%H:%M"],
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%-m/%-d"],
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%m/%d/%y"],
        augend.hexcolor.new { case = "prefer_lower" },
        augend.date.new {
          pattern = "%m-%d-%y",
          only_valid = true,
          default_kind = "day",
          word = false,
        },
        augend.date.new {
          pattern = "%m-%d-%Y",
          only_valid = true,
          default_kind = "day",
          word = false,
        },
        augend.date.new {
          pattern = "%-m-%-d",
          only_valid = true,
          default_kind = "day",
          word = false,
        },
        augend.constant.new {
          elements = { "up", "down" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "left", "right" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "front", "back" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "forward", "backward" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "high", "low" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "cold", "hot" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "enable", "disable" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "on", "off" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "!=", "==" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "!==", "===" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "+", "-" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "++", "--" },
          word = false,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "and", "or" },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        },
        -- Monday
        augend.constant.new {
          elements = {
            "Mon",
            "Tue",
            "Wed",
            "Thur",
            "Fri",
            "Sat",
            "Sun",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
          },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = {
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
          },
          word = true,
          cyclic = true,
        },
        augend.case.new {
          types = {
            "camelCase",
            "PascalCase",
            "kebab-case",
            "snake_case",
            "SCREAMING_SNAKE_CASE",
          },
          cyclic = true,
        },
      },
    }
  end,
}

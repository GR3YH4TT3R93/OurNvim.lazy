return {
  "Darazaki/indent-o-matic",
  -- event = "VeryLazy",
  config = function()
    require("indent-o-matic").setup({
      -- Global settings (optional, used as fallback)
      max_lines = 2048,
      standard_widths = { 2, 4 },
      skip_multiline = true,

      -- Disable indent-o-matic for LISP files
      filetype_lisp = {
        max_lines = 0,
      },

      -- Only detect 4 spaces and tabs for Rust files
      filetype_rust = {
        standard_widths = { 4 },
      },

      -- Don't detect 8 spaces indentations inside files without a filetype
      filetype_ = {
        standard_widths = { 2, 4 },
      },
    })
  end,
}

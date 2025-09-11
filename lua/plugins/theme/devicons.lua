---@class LazyPlugin
return {
  "nvim-tree/nvim-web-devicons",
  opts = {
    override_by_filename = {
      [".zsh_aliases"] = {
        icon = "",
        color = "#89e051",
        cterm_color = "113",
        name = "ZshAliases",
      },
      [".zsh_history"] = {
        icon = "",
        color = "#89e051",
        cterm_color = "113",
        name = "ZshHistory",
      },
      [".bash_history"] = {
        icon = "",
        color = "#89e051",
        cterm_color = "113",
        name = "BashHistory",
      },
    },
  },
}

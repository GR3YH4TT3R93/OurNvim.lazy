local treesitter = require("nvim-treesitter")
local ts_config = require("nvim-treesitter.config")
treesitter.setup {
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath("data") .. "/tree-sitter",
}

local ensure_installed = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "vue",
  "ecma",
  "typescript",
  "javascript",
  "html",
  "css",
  "json",
  "jsonc",
  "bash",
  "go",
  "gomod",
  "gosum",
  "gitcommit",
  "gitignore",
  "git_rebase",
  "git_config",
  "regex",
  "rust",
  "diff",
  "markdown",
  "markdown_inline",
  "toml",
  "yaml",
  "properties",
}
local syntax_map = {
  -- ["tiltfile"] = "starlark",
}
local already_installed = ts_config.get_installed("parsers")
local parsers_to_install = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()
if #parsers_to_install > 0 then
  treesitter.install(parsers_to_install)
end

local function ts_start(bufnr, parser_name)
  vim.treesitter.start(bufnr, parser_name)
  -- Use regex based syntax-highlighting as fallback as some plugins might need it
  vim.bo[bufnr].syntax = "ON"
  -- Use treesitter for folds
  -- vim.wo.foldlevel = 99
  -- vim.wo.foldmethod = "expr"
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
  -- Use treesitter for indentation
  -- vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

-- Auto-install and start parsers for any buffer
vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Enable Treesitter",
  callback = function(event)
    local bufnr = event.buf
    local filetype = event.match

    -- Skip if no filetype
    if filetype == "" then
      return
    end

    -- Get parser name based on filetype
    local lang = vim.tbl_get(syntax_map, filetype)
    if lang == nil then
      lang = filetype
    else
      vim.notify("Using language override " .. lang)
    end
    local parser_name = vim.treesitter.language.get_lang(lang)
    if not parser_name then
      vim.notify(
        vim.inspect("No treesitter parser found for filetype: " .. lang),
        vim.log.levels.WARN
      )
      return
    end

    -- Try to get existing parser
    if not vim.tbl_contains(ts_config.get_available(), parser_name) then
      return
    end

    -- Check if parser is already installed
    if not vim.tbl_contains(already_installed, parser_name) then
      -- If not installed, install parser asynchronously and start treesitter
      vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
      treesitter.install({ parser_name }):await(function()
        ts_start(bufnr, parser_name)
      end)
      return
    end

    -- Start treesitter for this buffer
    ts_start(bufnr, parser_name)
  end,
})

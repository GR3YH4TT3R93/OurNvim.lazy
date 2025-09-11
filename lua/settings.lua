local o = vim.o
local opt = vim.opt

-- General settings
o.updatetime = 100
o.autowriteall = true
o.confirm = true

-- Backup settings
o.bex = ".bak"
o.backup = false
o.writebackup = false

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Appearance settings
o.signcolumn = "yes"
o.number = true
o.relativenumber = true
-- o.cursorline = true
o.scrolloff = 999
o.foldmethod = "marker"
-- o.foldmethod = "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldnestmax = 3
-- o.pumblend = 1

-- Format options
o.wrap = true
o.linebreak = true
o.textwidth = 80
o.breakindent = true

-- Mouse settings
vim.o.mousemoveevent = true

-- Completion settings
opt.completeopt = { "menuone", "noinsert", "popup", "preview" }

-- Clipboard settings
vim.schedule(function()
  opt.clipboard:append { "unnamedplus", "unnamed" }
end)

-- LSP settings
vim.lsp.log.set_level("OFF")

-- Diagnostic settings
-- vim.diagnostic.config { virtual_text = true }

-- Filetype settings
vim.filetype.add {
  extension = {
    ["http"] = "http",
  },
}

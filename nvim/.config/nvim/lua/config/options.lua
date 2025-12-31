-- Options migrated from vim config
local opt = vim.opt

-- Leader keys and filetype/syntax are set in init.lua before loading lazy.nvim

-- Terminal
opt.termguicolors = true -- Enable 24-bit RGB colors

-- File formats
opt.fileencoding = "utf-8"
opt.fileformats = { "unix", "mac", "dos" }

-- Edit settings
opt.autoread = true
-- Note: paste option is not needed in Neovim (bracketed paste mode is enabled by default)
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true
opt.backspace = { "indent", "eol", "start" }
opt.scrolloff = 10
opt.hidden = true

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true

-- View settings
opt.number = true
opt.signcolumn = "yes" -- Always show sign column (for LSP errors/warnings)
opt.list = true
opt.listchars = { tab = "▸ ", trail = "-", extends = "»", precedes = "«", nbsp = "%" }
opt.laststatus = 2
opt.showcmd = false
opt.title = false
opt.showtabline = 0
opt.showmode = false
opt.linebreak = true
opt.breakindent = true
opt.wrap = true
opt.cursorline = true
opt.colorcolumn = "79"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 20

-- Split windows
opt.splitbelow = true
opt.splitright = true
opt.winwidth = 30
opt.winheight = 1

-- Folding
opt.foldenable = true
opt.foldmethod = "marker"
opt.foldcolumn = "1"
opt.fillchars = { vert = "|" }

-- Misc
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 100
opt.updatetime = 1000
opt.virtualedit = "block"
opt.display = "lastline"
opt.report = 0
opt.startofline = false

-- Clipboard
if vim.fn.has("clipboard") == 1 then
  if vim.fn.has("unnamedplus") == 1 then
    opt.clipboard:append("unnamedplus")
  else
    opt.clipboard:append("unnamed")
  end
end

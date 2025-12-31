-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = ","
vim.g.maplocalleader = "m"

-- Enable filetype detection BEFORE loading lazy.nvim
-- Note: syntax highlighting is handled by Treesitter, not vim's built-in syntax
vim.cmd("filetype plugin indent on")

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load configurations
require("config.options")
require("config.keymaps")
require("config.autocmds")

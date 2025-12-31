-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = ","
vim.g.maplocalleader = "m"

-- Enable filetype detection and syntax BEFORE loading lazy.nvim
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load configurations
require("config.options")
require("config.keymaps")
require("config.autocmds")

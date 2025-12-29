-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = ","
vim.g.maplocalleader = "m"

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load configurations
require("config.options")
require("config.keymaps")
require("config.autocmds")

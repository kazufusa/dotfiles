-- Colorscheme configuration
return {
  {
    "rafi/awesome-vim-colorschemes",
    priority = 1000,
    config = function()
      -- Set background before colorscheme
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
}

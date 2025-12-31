-- Colorscheme configuration
return {
  {
    "rafi/awesome-vim-colorschemes",
    lazy = false, -- Load immediately on startup
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd("colorscheme deus")
      -- Force pure black background for maximum contrast
      vim.cmd("highlight Normal guibg=#000000")
      vim.cmd("highlight NormalNC guibg=#000000")
    end,
  },
}

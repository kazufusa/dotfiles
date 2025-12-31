-- Keymaps migrated from vim config
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Swap line/normal visual mode
keymap("n", "V", "v", opts)
keymap("n", "v", "V", opts)
keymap("x", "V", "v", opts)
keymap("x", "v", "V", opts)

-- Yank to end of line
keymap("n", "Y", "y$", opts)

-- Remove trailing spaces
keymap("n", ",<Space>", ":<C-u>silent! keeppatterns %substitute/\\s\\+$//e<CR>", opts)

-- Clear search highlight and disable paste
keymap("n", "<Esc><Esc>", ":<C-u>set nopaste<CR>:nohlsearch<CR>", opts)

-- Re-select visual block after indenting
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Command-line mode keymappings (emacs-like)
keymap("c", "<C-a>", "<Home>", { noremap = true })
keymap("c", "<C-b>", "<Left>", { noremap = true })
keymap("c", "<C-d>", "<Del>", { noremap = true })
keymap("c", "<C-e>", "<End>", { noremap = true })
keymap("c", "<C-f>", "<Right>", { noremap = true })
keymap("c", "<C-n>", "<Down>", { noremap = true })

-- Save with Ctrl-S (save and return to normal mode from any mode)
keymap("n", "<C-s>", ":<C-u>wa<CR>", opts)
keymap("i", "<C-s>", "<ESC>:<C-u>wa<CR>", opts)
keymap("v", "<C-s>", "<ESC>:<C-u>wa<CR>", opts)
keymap("x", "<C-s>", "<ESC>:<C-u>wa<CR>", opts)
keymap("c", "<C-s>", "<C-u>wa<CR>", { noremap = true })

-- Diff toggle
keymap("n", ",d", function()
  if vim.wo.diff then
    vim.cmd("diffoff")
  else
    vim.cmd("diffthis")
  end
end, opts)

-- Tags
keymap("n", "<C-@>", "<C-t>", opts)

-- GGrep command (git grep with Telescope)
vim.api.nvim_create_user_command("GGrep", function(opts)
  require("telescope.builtin").live_grep({
    prompt_title = "Git Grep",
    cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
    additional_args = function()
      return { "--fixed-strings" }
    end,
    default_text = opts.args,
  })
end, { nargs = "*", desc = "Git grep with Telescope" })

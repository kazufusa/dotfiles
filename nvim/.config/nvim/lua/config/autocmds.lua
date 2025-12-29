-- Autocmds migrated from vim config
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General autocmd group
local general = augroup("General", { clear = true })

-- Check timestamp more for autoread
autocmd("WinEnter", {
  group = general,
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Update diff on insert leave
autocmd("InsertLeave", {
  group = general,
  callback = function()
    if vim.wo.diff then
      vim.cmd("diffupdate")
    end
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Create directory if it doesn't exist when saving
autocmd("BufWritePre", {
  group = general,
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      local choice = vim.fn.input(string.format('"%s" does not exist. Create? [y/N] ', dir))
      if choice:match("^y") then
        vim.fn.mkdir(dir, "p")
      end
    end
  end,
})

-- Filetype specific indentation
local filetype_indent = augroup("FileTypeIndent", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_indent,
  pattern = "*.go",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

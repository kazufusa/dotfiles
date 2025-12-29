-- Conform.nvim - Project-local script formatting
-- Automatically detects and uses project-local format scripts.
--
-- === How to use ===
-- Create one of these scripts in your project root:
--   - tmp/format.sh
--   - .format.sh
--   - scripts/format.sh
--
-- The script receives the filename as argument and should format in-place:
--   #!/bin/bash
--   # Example: tmp/format.sh
--   prettier --write "$1"
--   eslint --fix "$1"
--
-- Make it executable:
--   chmod +x tmp/format.sh
--
-- If no script is found, falls back to LSP formatter.
--
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<C-l>f",
        function()
          require("conform").format({
            async = true,
            lsp_fallback = true,
            timeout_ms = 3000,
          })
        end,
        mode = { "n", "v" },
        desc = "Format buffer/selection",
      },
    },
    config = function()
      local conform = require("conform")

      -- Helper to find project-local format script
      local function find_format_script()
        local script_paths = {
          "tmp/format.sh",
          ".format.sh",
          "scripts/format.sh",
        }
        for _, path in ipairs(script_paths) do
          local full_path = vim.fn.getcwd() .. "/" .. path
          if vim.fn.executable(full_path) == 1 then
            return full_path
          end
        end
        return nil
      end

      -- Custom formatter that uses project-local script
      conform.formatters.project_script = {
        command = function()
          return find_format_script() or "cat" -- fallback to cat if no script
        end,
        args = { "$FILENAME" },
        stdin = false,
      }

      -- Determine formatters_by_ft dynamically
      local function get_formatters()
        if find_format_script() then
          return { "project_script" }
        else
          return {} -- Fall back to LSP
        end
      end

      conform.setup({
        formatters_by_ft = {
          -- Use project script for all filetypes if available
          ["*"] = function()
            return get_formatters()
          end,
        },
        formatters = {
          project_script = {
            command = function()
              return find_format_script() or "cat"
            end,
            args = { "$FILENAME" },
            stdin = false,
          },
        },
        notify_on_error = true,
      })
    end,
  },
}

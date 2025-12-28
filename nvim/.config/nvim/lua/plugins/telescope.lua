-- Telescope configuration (fzf replacement)
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      -- File pickers (matching vim fzf keybindings)
      { "<C-f>a", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<C-f>f", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<C-f>d", "<cmd>Telescope git_status<cr>", desc = "Git Diff (Changed Files)" },
      { "<C-f>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<C-f>m", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<C-f>h", "<cmd>Telescope command_history<cr>", desc = "Command History" },

      -- Search
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word" },

      -- LSP
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },

      -- Others
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "> ",
          selection_caret = "> ",
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git/", "vendor/" },
          layout_strategy = "flex",
          layout_config = {
            height = 0.9,
            width = 0.9,
            horizontal = {
              preview_width = 0.6,
            },
            vertical = {
              preview_height = 0.5,
            },
          },
          -- Disable color codes in preview
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          git_status = {
            previewer = require("telescope.previewers").new_termopen_previewer({
              get_command = function(entry)
                -- entry.value is the file path for git_status
                if entry.status == "??" then
                  -- For untracked files, show the file content
                  return { "cat", entry.value }
                elseif entry.status == " D" then
                  -- For deleted files, show from HEAD
                  return { "git", "show", "HEAD:" .. entry.value }
                else
                  -- For modified files, show colored diff without header (only @@ and content)
                  return {
                    "sh",
                    "-c",
                    string.format(
                      "git -c color.diff=always diff --color=always HEAD -- %s | awk '/@@/{p=1} p'",
                      vim.fn.shellescape(entry.value)
                    ),
                  }
                end
              end,
            }),
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
    end,
  },
}

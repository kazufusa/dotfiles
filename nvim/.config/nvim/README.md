# 💕 Neovim Configuration

A modern, high-performance Neovim configuration with LSP support, flexible formatting, and project-local customization.

## ✨ Features

- 🚀 **Lightning-fast startup** with lazy loading
- 🔧 **Full LSP support** with Mason for easy language server management
- 🎨 **Gruvbox colorscheme** with Treesitter syntax highlighting
- 🔍 **Telescope fuzzy finder** with git integration
- 💅 **Flexible formatting** with project-local script support
- 📝 **Smart completion** with nvim-cmp and snippets
- 🌈 **Rainbow delimiters** and auto-pairs
- 📊 **Git integration** with gitsigns and diff previews
- ⚡ **Optimized for performance** - no redundant plugins or settings

## 📋 Requirements

### Required
- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons and powerline (recommended: JetBrains Mono Nerd Font)
- `ripgrep` (for Telescope grep)

### Optional (for formatting)
- Node.js & npm (for Prettier, TypeScript formatters)
- Python & pip (for Black, isort)
- Go (for gofmt, goimports)
- Rust & cargo (for stylua, rustfmt)

## 🚀 Installation

### 1. Backup existing config
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 2. Clone this configuration
```bash
# If using stow (recommended)
cd ~/dotfiles
stow nvim

# Or copy directly
cp -r nvim/.config/nvim ~/.config/
```

### 3. Launch Neovim
```bash
nvim
```

On first launch, lazy.nvim will automatically:
- Install itself
- Install all plugins
- Set up LSP servers via Mason

### 4. Install LSP servers (if needed)
```vim
:Mason
```

Select language servers to install (recommended: lua_ls, ts_ls, gopls, rust_analyzer, pyright)

## ⌨️ Keybindings

### Leader Keys
- **Leader**: `,`
- **LocalLeader**: `m`

### Essential Keybindings

#### General
| Key | Mode | Action |
|-----|------|--------|
| `<C-s>` | All | Save all buffers and return to normal mode |
| `<Esc><Esc>` | Normal | Clear search highlighting |
| `Y` | Normal | Yank to end of line |
| `v` | Normal | Visual line mode (swapped with V) |
| `V` | Normal | Visual block mode (swapped with v) |
| `>` | Visual | Indent and re-select |
| `<` | Visual | Unindent and re-select |
| `,<Space>` | Normal | Remove trailing whitespace |
| `,d` | Normal | Toggle diff mode |
| `<C-@>` | Normal | Jump back to previous tag |

#### LSP
| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Show references |
| `K` | Normal | Hover documentation |
| `<C-k>` | Normal | Signature help |
| `<C-l>r` | Normal | Rename symbol |
| `<C-l>f` | Normal/Visual | Format buffer/selection |
| `<leader>ca` | Normal | Code actions |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>e` | Normal | Open diagnostic float |

#### Telescope (Fuzzy Finder)
| Key | Mode | Action |
|-----|------|--------|
| `<C-f>a` | Normal | Find all files |
| `<C-f>f` | Normal | Find git files |
| `<C-f>d` | Normal | Git diff (changed files with preview) |
| `<C-f>b` | Normal | Find buffers |
| `<C-f>m` | Normal | Find recent files (MRU) |
| `<C-f>h` | Normal | Command history |
| `<leader>sg` | Normal | Live grep |
| `<leader>sw` | Normal | Grep word under cursor |
| `<leader>ss` | Normal | Document symbols |
| `<leader>sS` | Normal | Workspace symbols |
| `<leader>sh` | Normal | Help tags |
| `<leader>sk` | Normal | Keymaps |

**Inside Telescope:**
- `j/k` or `<C-j>/<C-k>`: Navigate results
- `<C-c>` or `q`: Close
- `<CR>`: Select
- `<C-q>`: Send to quickfix list

#### Git (gitsigns)
| Key | Mode | Action |
|-----|------|--------|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>hs` | Normal | Stage hunk |
| `<leader>hr` | Normal | Reset hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |

#### Comments
| Key | Mode | Action |
|-----|------|--------|
| `__` | Normal | Toggle line comment |
| `__` | Visual | Toggle block comment |

#### Command-line (Emacs-style)
| Key | Mode | Action |
|-----|------|--------|
| `<C-a>` | Command | Move to beginning |
| `<C-e>` | Command | Move to end |
| `<C-b>` | Command | Move backward |
| `<C-f>` | Command | Move forward |
| `<C-d>` | Command | Delete character |
| `<C-n>` | Command | Move down in history |

#### Completion (nvim-cmp)
| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | Insert | Next completion item / Expand snippet |
| `<S-Tab>` | Insert | Previous completion item / Jump back in snippet |
| `<CR>` | Insert | Confirm completion |
| `<C-Space>` | Insert | Trigger completion |
| `<C-e>` | Insert | Abort completion |
| `<C-b>` | Insert | Scroll docs up |
| `<C-f>` | Insert | Scroll docs down |

#### Snippets
| Trigger | Output |
|---------|--------|
| `datetime` | Current datetime (e.g., `2025-12-29T15:30:00`) |
| `date` | Current date (e.g., `2025-12-29`) |
| `time` | Current time (e.g., `15:30:00`) |

## 🎨 Plugins

### Plugin Manager
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager with lazy loading

### LSP & Completion
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP server installer
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridge between Mason and lspconfig
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection

### Formatting
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Format runner with project-local script support

### Fuzzy Finder
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF sorter

### Syntax & UI
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Advanced syntax highlighting
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - Colorscheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) - Rainbow parentheses

### Utilities
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Smart commenting
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-close pairs
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding hints

## 🔧 Project-Local Formatting

This configuration supports **project-local format scripts** for maximum flexibility.

### How it works

1. Create a format script in your project root:
   - `tmp/format.sh` (recommended)
   - `.format.sh`
   - `scripts/format.sh`

2. Make it executable:
   ```bash
   chmod +x tmp/format.sh
   ```

3. The script receives the filename as `$1`:
   ```bash
   #!/bin/bash
   # tmp/format.sh - Your custom formatter

   prettier --write "$1"
   eslint --fix "$1"
   ```

4. Press `<C-l>f` to format using your script

### Example format scripts

#### JavaScript/TypeScript
```bash
#!/bin/bash
prettier --write "$1"
eslint --fix "$1"
```

#### Python
```bash
#!/bin/bash
black "$1"
isort "$1"
# Remove trailing whitespace
sed -i 's/[ \t]*$//' "$1"
```

#### Go
```bash
#!/bin/bash
goimports -w "$1"
gofmt -w "$1"
```

#### Multi-language
```bash
#!/bin/bash
case "$1" in
  *.js|*.ts|*.jsx|*.tsx)
    prettier --write "$1"
    ;;
  *.py)
    black "$1"
    isort "$1"
    ;;
  *.go)
    goimports -w "$1"
    ;;
  *)
    echo "No formatter configured for $1"
    ;;
esac
```

### Format on Save (Optional)

To enable automatic formatting on save for a specific project, create `.nvim.lua` in the project root:

```lua
-- .nvim.lua - Project-local nvim config
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf, lsp_fallback = true })
  end,
})
```

## 📁 Directory Structure

```
nvim/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua        # Lazy.nvim setup
│   │   ├── options.lua     # Vim options
│   │   ├── keymaps.lua     # Global keymaps
│   │   └── autocmds.lua    # Autocommands
│   └── plugins/
│       ├── lsp.lua         # LSP configuration
│       ├── completion.lua  # nvim-cmp & snippets
│       ├── conform.lua     # Formatting
│       ├── telescope.lua   # Fuzzy finder
│       ├── treesitter.lua  # Syntax highlighting
│       ├── colorscheme.lua # Theme
│       └── utils.lua       # Utility plugins
└── README.md               # This file
```

## 🎯 Language Support

Pre-configured LSP servers (install via `:Mason`):
- **Lua**: lua_ls
- **TypeScript/JavaScript**: ts_ls
- **Go**: gopls
- **Rust**: rust_analyzer
- **Python**: pyright

Add more via Mason or configure in `lua/plugins/lsp.lua`.

## 🐛 Troubleshooting

### LSP not working
1. Check if language server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart LSP: `:LspRestart`

### Formatters not found
Install formatters globally or use project-local script:
```bash
npm install -g prettier
pip install black isort
brew install stylua shfmt
```

### Slow startup
- Check lazy loading: `:Lazy profile`
- Most plugins should show `not loaded` initially

### Snippets not working
- Ensure LuaSnip is loaded: `:Lazy load LuaSnip`
- Custom snippets: `datetime`, `date`, `time`

## 💡 Tips

1. **Use project-local configs**: Create `.nvim.lua` in project roots for project-specific settings
2. **Explore keybindings**: Press `,` (leader) and wait 1 second to see available keybindings
3. **Customize formatters**: Use `tmp/format.sh` for flexible, per-project formatting
4. **Git diff preview**: Press `<C-f>d` to see changed files with colored diff previews
5. **Quick save**: Press `<C-s>` from any mode to save and return to normal mode

## 🤝 Contributing

This is a personal configuration, but feel free to:
- Fork and customize for your needs
- Open issues for bugs
- Share improvements via pull requests

## 📝 License

MIT License - Feel free to use and modify as you wish.

---

**Built with love and optimized for performance** 💕

# dotfiles

curl -L https://raw.githubusercontent.com/kazufusa/dotfiles/refs/heads/main/scripts/setup.sh | bash

```sh
./make.sh brew tow
```

## 📦 Configurations

### 💕 Neovim
Modern, high-performance Neovim configuration with LSP support and flexible formatting.

**[📖 Full Documentation →](nvim/.config/nvim/README.md)**

Features:
- 🚀 Lightning-fast startup with lazy loading
- 🔧 Full LSP support (Lua, TypeScript, Go, Rust, Python)
- 💅 Project-local format script support (`tmp/format.sh`)
- 🔍 Telescope fuzzy finder with git integration
- 🎨 Gruvbox theme with Treesitter

Quick install:
```bash
stow nvim
nvim  # Plugins auto-install on first launch
```

## TODO

```
zmodule olets/zsh-abbr
zmodule fzf
zmodule completion
zmodule archive
zmodule asdf
zmodule exa
zmodule utility
```

- vim
- nvim
- misc zsh plugins
- brewfile

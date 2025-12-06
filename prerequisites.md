# 🚀 Prerequisites & Installation

## System Requirements
```bash
# Neovim (latest version)
brew install neovim

# Essential development tools
xcode-select --install  # Command line tools
brew install git make cmake
```

## Optional but Recommended
```bash
# Nerd Font (required for icons)
brew install font-jetbrains-mono-nerd-font
# OR download from: https://www.nerdfonts.com/font-downloads
```

---

# 📦 Plugin Dependencies

## Core Plugins with External Requirements

| Plugin             | External Dependency       | Install Command               | Purpose                        |
| ------------------ | ------------------------- | ----------------------------- | ------------------------------ |
| **lazygit.nvim**   | lazygit                   | `brew install lazygit`        | Git interface                  |
| **img-clip.nvim**  | pngpaste                  | `brew install pngpaste`       | Clipboard image support        |
| **telescope.nvim** | ripgrep, fd, bat          | `brew install ripgrep fd bat` | Enhanced search & file finding |
| **avante.nvim**    | GitHub Copilot + pngpaste | `:Copilot auth` + brew cmd    | AI coding assistant            |
| **nvim-dbee**      | Database binary           | Auto-installed                | Database management            |
| **go.nvim**        | Go binaries               | Auto-installed via plugin     | Go development tools           |

## Development Environment Setup
```bash
# Essential Neovim utilities
brew install neovim git make cmake lazygit pngpaste ripgrep fd bat

# For GraphQL projects root, create .graphqlrc.json:
cat > .graphqlrc.json << EOF
{
  "schema": "path/to/schema/*.graphql",
  "documents": ["apps/**/*.graphql", "libs/**/*.graphql"]
}
EOF
```
---
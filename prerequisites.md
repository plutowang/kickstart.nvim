# 🚀 Prerequisites & Installation

## System Requirements
```bash
# Neovim (latest version)
brew install neovim

# Essential development tools
xcode-select --install  # Command line tools
brew install git make cmake

# Tree-sitter CLI (required for nvim-treesitter main branch)
cargo install tree-sitter-cli
# Ensure cargo bin is in PATH:
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Optional but Recommended
```bash
# Nerd Font (required for icons)
brew install font-jetbrains-mono-nerd-font
# OR download from: https://www.nerdfonts.com/font-downloads
```

---

# 📦 Plugin Dependencies

## nvim-treesitter Configuration Notes
**Important**: This config uses nvim-treesitter `main` branch (not `master`)
- **Required**: tree-sitter CLI version 0.25.0+ 
- **Installation method**: Manual parser installation via `:TSInstall`
- **No auto-install**: Parsers must be installed individually for better control

## Core Plugins with External Requirements

| Plugin              | External Dependency       | Install Command                 | Purpose                        |
| ------------------- | ------------------------- | ------------------------------- | ------------------------------ |
| **nvim-treesitter** | tree-sitter CLI           | `cargo install tree-sitter-cli` | Syntax highlighting & parsing  |
| **lazygit.nvim**    | lazygit                   | `brew install lazygit`          | Git interface                  |
| **img-clip.nvim**   | pngpaste                  | `brew install pngpaste`         | Clipboard image support        |
| **telescope.nvim**  | ripgrep, fd, bat          | `brew install ripgrep fd bat`   | Enhanced search & file finding |
| **avante.nvim**     | GitHub Copilot + pngpaste | `:Copilot auth` + brew cmd      | AI coding assistant            |
| **nvim-dbee**       | Database binary           | Auto-installed                  | Database management            |
| **go.nvim**         | Go binaries               | Auto-installed via plugin       | Go development tools           |

## Complete Development Environment Setup

```bash
# Install Rust (for tree-sitter-cli)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Essential Neovim utilities
brew install neovim git make cmake lazygit pngpaste ripgrep fd bat

# Tree-sitter CLI
cargo install tree-sitter-cli

# Update shell configuration
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## GraphQL Project Configuration

For GraphQL projects, create `.graphqlrc.json` in your project root:

```bash
cat > .graphqlrc.json << EOF
{
  "schema": "path/to/schema/*.graphql",
  "documents": ["apps/**/*.graphql", "libs/**/*.graphql"]
}
EOF
```

This configuration file is **required** for the GraphQL LSP to provide:
- Schema validation
- Auto-completion
- Error checking
- Go-to-definition support

---
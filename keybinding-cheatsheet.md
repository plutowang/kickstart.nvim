# Neovim Keybinding Cheatsheet

*Leader key: `<Space>`*

## 📂 File & Buffer Management

### Buffer Navigation (Barbar)
| Key           | Action                     |
| ------------- | -------------------------- |
| `<leader>1-9` | Go to buffer 1-9           |
| `<leader>0`   | Go to last buffer          |
| `<Ctrl+h>`    | Previous buffer            |
| `<Ctrl+l>`    | Next buffer                |
| `<Ctrl+x>`    | Close buffer               |
| `<Alt+h>`     | Move buffer left           |
| `<Alt+l>`     | Move buffer right          |
| `<leader>od`  | Order buffers by directory |
| `<leader>ol`  | Order buffers by language  |

### File Explorer (Neo-tree)
| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>re` | Root Explorer (from /)   |
| `<leader>fe` | File Explorer (from cwd) |
| `<leader>ge` | Git Explorer             |
| `<leader>be` | Buffer Explorer          |

## 🔍 Search & Navigation

### Telescope
| Key                | Action                         |
| ------------------ | ------------------------------ |
| `<leader>sh`       | Search Help                    |
| `<leader>sk`       | Search Keymaps                 |
| `<leader>sf`       | Search Files                   |
| `<leader>ss`       | Search Select Telescope        |
| `<leader>sw`       | Search current Word            |
| `<leader>sg`       | Search by Grep                 |
| `<leader>sd`       | Search Diagnostics             |
| `<leader>sr`       | Search Resume                  |
| `<leader>s.`       | Search Recent Files            |
| `<leader><leader>` | Find existing buffers          |
| `<leader>/`        | Fuzzy search in current buffer |
| `<leader>s/`       | Search in Open Files           |
| `<leader>sn`       | Search Neovim config files     |

### Flash (Quick Navigation)
| Key        | Action                             |
| ---------- | ---------------------------------- |
| `s`        | Flash jump                         |
| `S`        | Flash treesitter                   |
| `r`        | Remote flash (operator mode)       |
| `R`        | Treesitter search                  |
| `<Ctrl+s>` | Toggle flash search (command mode) |

## 🖥️ Terminal

### ToggleTerm
| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>tt` | Toggle Terminal Horizontal |
| `<leader>tv` | Toggle Terminal Vertical   |
| `<leader>tf` | Toggle Terminal Float      |
| `<leader>ts` | Send lines to Terminal     |

## 🔧 Development Tools

### LSP (Language Server)
| Key          | Action                |
| ------------ | --------------------- |
| `grn`        | Rename symbol         |
| `gra`        | Code Action           |
| `grr`        | Go to References      |
| `gri`        | Go to Implementation  |
| `grd`        | Go to Definition      |
| `grD`        | Go to Declaration     |
| `gO`         | Document Symbols      |
| `gW`         | Workspace Symbols     |
| `grt`        | Go to Type Definition |
| `<leader>th` | Toggle Inlay Hints    |

### Formatting
| Key         | Action        |
| ----------- | ------------- |
| `<leader>f` | Format buffer |

### Testing (Neotest)
| Key           | Action             |
| ------------- | ------------------ |
| `<leader>rt`  | Test menu          |
| `<leader>rtt` | Run File tests     |
| `<leader>rtT` | Run All test files |
| `<leader>rtr` | Run nearest test   |

### Database (nvim-dbee)
| Key          | Action             |
| ------------ | ------------------ |
| `<leader>db` | Toggle Database UI |
| `<leader>de` | Execute Query      |

## 🤖 AI Tools

### Avante (AI Assistant)
| Key          | Action         |
| ------------ | -------------- |
| `<leader>aa` | Avante Ask     |
| `<leader>an` | Avante New ask |

### Git

#### LazyGit
| Key          | Action       |
| ------------ | ------------ |
| `<leader>lg` | Open LazyGit |

## 🪟 Window Management

### Window Navigation
| Key        | Action               |
| ---------- | -------------------- |
| `<Ctrl+h>` | Move to left window  |
| `<Ctrl+l>` | Move to right window |
| `<Ctrl+j>` | Move to lower window |
| `<Ctrl+k>` | Move to upper window |

## ⌨️ Basic Editing

### General
| Key          | Action                        |
| ------------ | ----------------------------- |
| `<Esc>`      | Clear search highlights       |
| `<leader>q`  | Open diagnostic quickfix list |
| `<Esc><Esc>` | Exit terminal mode            |

### Completion (Blink.cmp)
| Key                 | Action                        |
| ------------------- | ----------------------------- |
| `<Ctrl+y>`          | Accept completion             |
| `<Tab>/<S-Tab>`     | Navigate snippet placeholders |
| `<Ctrl+Space>`      | Open completion menu          |
| `<Ctrl+n>/<Ctrl+p>` | Select next/previous item     |
| `<Up>/<Down>`       | Select next/previous item     |
| `<Ctrl+e>`          | Hide completion menu          |
| `<Ctrl+k>`          | Toggle signature help         |

## 🎨 UI & Display

### Which-key
| Key         | Action        |
| ----------- | ------------- |
| `<leader>s` | Search menu   |
| `<leader>t` | Toggle menu   |
| `<leader>h` | Git Hunk menu |

## 📁 File Types

### Commands Available
- `:StartupTime` - Show startup time analysis
- `:Lazy` - Open plugin manager
- `:Mason` - Open LSP installer
- `:LazyGit` - Open git interface
- `:Telescope` - Open telescope
- `:Neotest` - Open test interface
- `:Dbee` - Open database interface

## ⚙️ Settings

### Auto-behaviors
- Auto-save on focus lost or buffer leave
- Auto-reload files when modified externally
- Clipboard synced with OS
- Relative line numbers enabled
- Spell checking enabled for text files only

---

*Note: All keybindings use `<Space>` as the leader key. Some plugins may have additional keybindings available through their interfaces.*
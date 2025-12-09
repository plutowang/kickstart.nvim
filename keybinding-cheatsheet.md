# Neovim Keybinding Cheatsheet

- *Leader key: `<Space>`*

- *Note: `<C-*>` means `<Ctrl-*>`*

## 📂 File & Buffer Management

### Buffer Navigation (Barbar)
| Key           | Action                     |
| ------------- | -------------------------- |
| `<leader>1-9` | Go to buffer 1-9           |
| `<leader>0`   | Go to last buffer          |
| `<C-h>`       | Previous buffer            |
| `<C-l>`       | Next buffer                |
| `<C-x>`       | Close buffer               |
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
| Key     | Action                             |
| ------- | ---------------------------------- |
| `s`     | Flash jump                         |
| `S`     | Flash treesitter                   |
| `r`     | Remote flash (operator mode)       |
| `R`     | Treesitter search                  |
| `<C-s>` | Toggle flash search (command mode) |

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
| Key          | Action                         |
| ------------ | ------------------------------ |
| `grn`        | Rename symbol                  |
| `gra`        | Code Action                    |
| `grr`        | Go to References               |
| `gri`        | Go to Implementation           |
| `grd`        | Go to Definition               |
| `grD`        | Go to Declaration              |
| `gO`         | Document Symbols               |
| `gW`         | Workspace Symbols              |
| `grt`        | Go to Type Definition          |
| `<leader>th` | Toggle Inlay Hints             |
| `<leader>e`  | Show diagnostic Error messages |
| `<leader>q`  | Open diagnostic Quickfix list  |

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

#### Gitsigns
| Key          | Action                         |
| ------------ | ------------------------------ |
| `]c`         | Jump to next git [c]hange      |
| `[c`         | Jump to previous git [c]hange  |
| `<leader>hs` | Git [s]tage hunk               |
| `<leader>hr` | Git [r]eset hunk               |
| `<leader>hS` | Git [S]tage buffer             |
| `<leader>hu` | Git [u]ndo stage hunk          |
| `<leader>hR` | Git [R]eset buffer             |
| `<leader>hp` | Git [p]review hunk             |
| `<leader>hb` | Git [b]lame line               |
| `<leader>hd` | Git [d]iff against index       |
| `<leader>hD` | Git [D]iff against last commit |
| `<leader>tb` | [T]oggle git show [b]lame line |
| `<leader>tD` | [T]oggle git show [D]eleted    |

#### LazyGit
| Key          | Action       |
| ------------ | ------------ |
| `<leader>lg` | Open LazyGit |

## 🪟 Window Management

### Window Navigation
| Key          | Action               |
| ------------ | -------------------- |
| `<C-w><C-h>` | Move to left window  |
| `<C-w><C-l>` | Move to right window |
| `<C-w><C-j>` | Move to lower window |
| `<C-w><C-k>` | Move to upper window |

### Code Folding
| Key  | Action                         |
| ---- | ------------------------------ |
| `za` | Toggle fold under cursor       |
| `zc` | Close fold under cursor        |
| `zo` | Open fold under cursor         |
| `zC` | Close all folds recursively    |
| `zO` | Open all folds recursively     |
| `zM` | Close all folds in buffer      |
| `zR` | Open all folds in buffer       |
| `zi` | Toggle folding on/off globally |
| `zj` | Move to next fold              |
| `zk` | Move to previous fold          |

## ⌨️ Basic Editing

### General
| Key          | Action                        |
| ------------ | ----------------------------- |
| `<Esc>`      | Clear search highlights       |
| `<leader>q`  | Open diagnostic quickfix list |
| `<Esc><Esc>` | Exit terminal mode            |

### Recording & Macros
| Key  | Action                    |
| ---- | ------------------------- |
| `qa` | Start recording macro 'a' |
| `q`  | Stop recording macro      |
| `@a` | Execute macro 'a'         |
| `@@` | Repeat last macro         |

### Spelling
| Key   | Action                       |
| ----- | ---------------------------- |
| `z=`  | Suggest spelling corrections |
| `zg`  | Add word to dictionary       |
| `zw`  | Mark word as misspelled      |
| `]s`  | Next misspelled word         |
| `[s`  | Previous misspelled word     |
| `zug` | Remove word from dictionary  |

### Text Objects (Treesitter)
| Key  | Action                      |
| ---- | --------------------------- |
| `am` | Select [A]round [M]ethod    |
| `im` | Select [I]nside [M]ethod    |
| `ac` | Select [A]round [C]lass     |
| `ic` | Select [I]nside [C]lass     |
| `aa` | Select [A]round P[a]rameter |
| `ia` | Select [I]nside P[a]rameter |
| `ab` | Select [A]round [B]lock     |
| `ib` | Select [I]nside [B]lock     |

### Text Object Movement
| Key  | Action                     |
| ---- | -------------------------- |
| `]m` | Next [m]ethod start        |
| `[m` | Previous [m]ethod start    |
| `]M` | Next [M]ethod end          |
| `[M` | Previous [M]ethod end      |
| `]]` | Next class start           |
| `[[` | Previous class start       |
| `][` | Next class end             |
| `[]` | Previous class end         |
| `]a` | Next p[a]rameter start     |
| `[a` | Previous p[a]rameter start |
| `]A` | Next p[A]rameter end       |
| `[A` | Previous p[A]rameter end   |
| `]b` | Next [b]lock start         |
| `[b` | Previous [b]lock start     |
| `]B` | Next [B]lock end           |
| `[B` | Previous [B]lock end       |

### Text Object Swapping
| Key          | Action                           |
| ------------ | -------------------------------- |
| `<leader>sa` | [S]wap p[a]rameter with next     |
| `<leader>sA` | [S]wap p[A]rameter with previous |
| `<leader>sm` | [S]wap [M]ethod with next        |
| `<leader>sM` | [S]wap [M]ethod with previous    |

### Additional Vim Operations
| Key      | Action                              |
| -------- | ----------------------------------- |
| `u`      | Undo                                |
| `<C-r>`  | Redo                                |
| `.`      | Repeat last command                 |
| `*`      | Search word under cursor            |
| `#`      | Search word under cursor (backward) |
| `%`      | Jump to matching bracket            |
| `gf`     | Go to file under cursor             |
| `<C-o>`  | Jump to previous location           |
| `<C-i>`  | Jump to next location               |
| `m{a-z}` | Set mark                            |
| `'{a-z}` | Jump to mark                        |

### Bracket & Quote Navigation
| Key  | Action                              |
| ---- | ----------------------------------- |
| `%`  | Jump to matching bracket/paren      |
| `[{` | Previous unmatched opening `{`      |
| `]}` | Next unmatched closing `}`          |
| `[(` | Previous unmatched opening `(`      |
| `])` | Next unmatched closing `)`          |
| `[%` | Previous unmatched opening bracket  |
| `]%` | Next unmatched closing bracket      |
| `f"` | Find next `"` on current line       |
| `F"` | Find previous `"` on current line   |
| `t"` | Till next `"` (stops before it)     |
| `T"` | Till previous `"` (stops before it) |
| `;`  | Repeat last f/F/t/T command         |
| `,`  | Repeat last f/F/t/T opposite dir    |

### Search & Replace
| Key/Command      | Action                                   |
| ---------------- | ---------------------------------------- |
| `/pattern`       | Search forward for pattern               |
| `?pattern`       | Search backward for pattern              |
| `n`              | Next search match                        |
| `N`              | Previous search match                    |
| `:s/old/new/`    | Replace first occurrence in current line |
| `:s/old/new/g`   | Replace all occurrences in current line  |
| `:%s/old/new/g`  | Replace all occurrences in file          |
| `:%s/old/new/gc` | Replace all with confirmation            |
| `:noh`           | Clear search highlights                  |

### Completion (Blink.cmp)
| Key             | Action                        |
| --------------- | ----------------------------- |
| `<C-y>`         | Accept completion             |
| `<Tab>/<S-Tab>` | Navigate snippet placeholders |
| `<C-Space>`     | Open completion menu          |
| `<C-n>/<C-p>`   | Select next/previous item     |
| `<Up>/<Down>`   | Select next/previous item     |
| `<C-e>`         | Hide completion menu          |
| `<C-k>`         | Toggle signature help         |

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

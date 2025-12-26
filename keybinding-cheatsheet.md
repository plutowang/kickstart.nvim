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
| `<M-h>/<A-h>` | Move buffer left           |
| `<M-l>/<A-l>` | Move buffer right          |
| `<leader>bo`  | Order buffers by directory |
| `<leader>bl`  | Order buffers by language  |

### File Explorer (Neo-tree)
| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>er` | Root Explorer (from /)   |
| `<leader>ef` | File Explorer (from cwd) |
| `<leader>eg` | Git Explorer             |
| `<leader>eb` | Buffer Explorer          |

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
| `gl`    | Flash: Go Leap                     |
| `gL`    | Flash: Go Leap Treesitter          |
| `r`     | Remote flash (operator mode)       |
| `R`     | Treesitter search                  |
| `<C-s>` | Toggle flash search (command mode) |

## 🖥️ Terminal

### Snacks Terminal
| Key          | Action                       |
| ------------ | ---------------------------- |
| `<leader>tt` | Toggle Terminal (default)    |
| `<leader>tf` | Toggle Terminal Float        |
| `<leader>tp` | Terminal Python REPL (float) |
| `<leader>to` | Terminal Node REPL (float)   |
| `<leader>ts` | Terminal Scratch Buffer      |
| `<leader>tS` | Toggle Select Scratch Buffer |
| `q`          | Hide terminal (in terminal)  |

### Buffer Operations (Snacks)
| Key          | Action               |
| ------------ | -------------------- |
| `<leader>bd` | Buffer Delete        |
| `<leader>bD` | Buffer Delete Force  |
| `<leader>bO` | Buffer Delete Others |
| `<leader>ba` | Buffer Delete All    |

### Git Operations (Snacks)
| Key          | Action         |
| ------------ | -------------- |
| `<leader>gb` | Git Browse     |
| `<leader>gB` | Git Blame Line |
| `<leader>gl` | Git Log        |
| `<leader>gg` | Lazy Git       |

### File Operations
| Key          | Action          |
| ------------ | --------------- |
| `<leader>ur` | Rename File     |
| `<leader>fr` | File Rename     |
| `<leader>fd` | File Duplicate  |
| `<leader>fn` | File New        |
| `<leader>uu` | Undotree toggle |

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


### Surround (nvim-surround)
| Key   | Mode   | Action                             |
| ----- | ------ | ---------------------------------- |
| `ys`  | Normal | Add surround (with motion)         |
| `yss` | Normal | Add surround to entire line        |
| `yS`  | Normal | Add surround with newlines         |
| `ySS` | Normal | Add surround with newlines to line |
| `ds`  | Normal | Delete surround                    |
| `cs`  | Normal | Change surround                    |
| `cS`  | Normal | Change surround with newlines      |
| `S`   | Visual | Add surround to selection          |
| `gS`  | Visual | Add surround with newlines         |

### Code Folding & Structure
| Key  | Action                  |
| ---- | ----------------------- |
| `gJ` | Join node under cursor  |
| `gS` | Split node under cursor |

### Formatting
| Key         | Action        |
| ----------- | ------------- |
| `<leader>f` | Format buffer |

### Testing (Neotest)
| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>rt` | Run Nearest Test        |
| `<leader>rf` | Run File tests          |
| `<leader>ra` | Run All tests           |
| `<leader>rl` | Run Last test           |
| `<leader>rs` | Run Stop                |
| `<leader>rS` | Run Toggle Summary      |
| `<leader>ro` | Run Output show         |
| `<leader>rO` | Run Toggle Output Panel |
| `<leader>rw` | Run Watch toggle        |

### Database (nvim-dbee)
| Key          | Action             |
| ------------ | ------------------ |
| `<leader>Dt` | Toggle Database UI |
| `<leader>De` | Execute Query      |

### REST Client (Kulala)
| Key          | Action            |
| ------------ | ----------------- |
| `<leader>Rs` | Send request      |
| `<leader>Ra` | Send all requests |
| `<leader>Rb` | Open scratchpad   |

### Debug (DAP)
| Key           | Action                         |
| ------------- | ------------------------------ |
| `<F5>`        | Debug: Start/Continue          |
| `<F1>`        | Debug: Step Into               |
| `<F2>`        | Debug: Step Over               |
| `<F3>`        | Debug: Step Out                |
| `<F7>`        | Debug: Toggle UI               |
| `<leader>db`  | Toggle Debug Breakpoint        |
| `<leader>dB`  | Debug Breakpoint Conditional   |
| `<leader>dx`  | Debug Clear All Breakpoints    |
| `<leader>dC`  | Debug Run to Cursor            |
| `<leader>dl`  | Debug Run Last                 |
| `<leader>dt`  | Debug Terminate                |
| `<leader>dp`  | Debug Pause                    |
| `<leader>dv`  | Debug: Toggle variable hover   |
| `<leader>dr`  | Debug: Evaluate in REPL        |
| `<leader>dfc` | <F5> Debug Continue/Start      |
| `<leader>dfi` | <F1> Debug Step Into           |
| `<leader>dfO` | <F2> Debug Step Over           |
| `<leader>dfo` | <F3> Debug Step Out            |
| `<leader>dfu` | <F7> Debug UI Toggle           |
| `<leader>dir` | Debug Inspection Toggle REPL   |
| `<leader>dis` | Debug Inspection Session Info  |
| `<leader>diw` | Debug Inspection Widget Hover  |
| `<leader>diW` | Debug Inspection Widget Scopes |

### Trouble (Diagnostics)
| Key          | Action                         |
| ------------ | ------------------------------ |
| `<leader>xx` | Diagnostics (Trouble)          |
| `<leader>xs` | Symbols (Trouble)              |
| `<leader>xQ` | Quickfix List (Trouble)        |
| `<leader>xe` | Show diagnostic Error messages |
| `<leader>xq` | Open diagnostic Quickfix list  |

## 🤖 AI Tools

### Avante (AI Assistant)
| Key          | Action                     |
| ------------ | -------------------------- |
| `<leader>aa` | Avante Ask                 |
| `<leader>an` | Avante New ask             |
| `<leader>am` | Toggle Mode (Chat/Agent)   |
| `ct`         | Accept Change (in Avante)  |
| `co`         | Reject Change (in Avante)  |
| `<leader>pi` | Paste Image from clipboard |

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

## 🪟 Window Management

### Window Navigation & Resizing
| Key          | Action                 |
| ------------ | ---------------------- |
| `<C-w><C-h>` | Move to left window    |
| `<C-w><C-l>` | Move to right window   |
| `<C-w><C-j>` | Move to lower window   |
| `<C-w><C-k>` | Move to upper window   |
| `>`          | Increase window width  |
| `<`          | Decrease window width  |
| `+`          | Increase window height |
| `-`          | Decrease window height |
| `=`          | Equalize window sizes  |

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
| `<leader>nh` | Clear search highlight        |

### Text Editing Enhancements
| Key          | Action                              |
| ------------ | ----------------------------------- |
| `<` (visual) | Indent left and reselect            |
| `>` (visual) | Indent right and reselect           |
| `J` (visual) | Move selection down                 |
| `K` (visual) | Move selection up                   |
| `p` (visual) | Paste without overwriting clipboard |
| `J` (normal) | Join lines without moving cursor    |
| `<C-d>`      | Scroll down and center              |
| `<C-u>`      | Scroll up and center                |
| `n`          | Next search result and center       |
| `N`          | Previous search result and center   |

### Utility & Settings
| Key          | Action                      |
| ------------ | --------------------------- |
| `<leader>fp` | Show File Path              |
| `<leader>uw` | Toggle line wrap            |
| `<leader>us` | Toggle spell check          |
| `<leader>uf` | Enable treesitter folding   |
| `<leader>ue` | Toggle experimental plugins |

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
| `<leader>wa` | [S]wap p[a]rameter with next     |
| `<leader>wA` | [S]wap p[A]rameter with previous |
| `<leader>wm` | [S]wap [m]ethod with next        |
| `<leader>wM` | [S]wap [M]ethod with previous    |

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

### Which-key Groups
| Key         | Group              |
| ----------- | ------------------ |
| `<leader>s` | [S]earch           |
| `<leader>e` | [E]xplorer         |
| `<leader>g` | [G]it              |
| `<leader>h` | Git [H]unk         |
| `<leader>r` | [R]un/Test         |
| `<leader>d` | [D]atabase/Debug   |
| `<leader>x` | Trouble/[X]        |
| `<leader>f` | [F]ormat           |
| `<leader>t` | [T]erminal/Toggle  |
| `<leader>a` | [A]I Assistant     |
| `<leader>w` | S[w]ap/Wrap        |
| `<leader>b` | [B]uffer           |
| `<leader>n` | [N]o/Clear         |
| `<leader>u` | [U]tility/Settings |
| `gr`        | LSP Actions        |

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


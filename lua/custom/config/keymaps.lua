-- ============================================================================
-- ENHANCED KEYMAPS
-- Better keybindings for improved workflow
-- ============================================================================

-- Setup keymaps immediately when file is loaded
local function setup_keymaps()
  local map = vim.keymap.set

  -- ============================================================================
  -- NAVIGATION & WINDOW MANAGEMENT
  -- ============================================================================

  -- Window resizing
  map("n", ">", [[<cmd>vertical resize +5<cr>]], { desc = 'Increase vertical size' })
  map("n", "<", [[<cmd>vertical resize -5<cr>]], { desc = 'Decrease vertical size' })
  map("n", "+", [[<cmd>horizontal resize +2<cr>]], { desc = 'Increase horizontal size' })
  map("n", "-", [[<cmd>horizontal resize -2<cr>]], { desc = 'Decrease horizontal size' })
  map("n", "=", [[<cmd>wincmd =<cr>]], { desc = 'Equalize window sizes' })

  -- ============================================================================
  -- TEXT EDITING ENHANCEMENTS
  -- ============================================================================

  -- Better indenting in visual mode
  map('v', '<', '<gv', { desc = 'Indent left and reselect' })
  map('v', '>', '>gv', { desc = 'Indent right and reselect' })

  -- Move text up and down
  map('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
  map('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

  -- Better paste in visual mode
  map('v', 'p', '"_dP', { desc = 'Paste without overwriting clipboard' })

  -- Join lines without moving cursor
  map('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })

  -- Center screen when navigating
  map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
  map('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
  map('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

  -- ============================================================================
  -- QUICK ACTIONS
  -- ============================================================================

  -- Clear search highlighting
  map('n', '<leader>nh', '<cmd>nohl<cr>', { desc = 'Clear search highlight' })

  -- Show file path
  map('n', '<leader>fp', '<cmd>echo expand("%:p")<cr>', { desc = 'Show [F]ile [P]ath' })

  -- Toggle line wrapping
  map('n', '<leader>uw', '<cmd>set wrap!<cr>', { desc = 'Toggle line wrap' })

  -- Toggle spell checking
  map('n', '<leader>us', '<cmd>set spell!<cr>', { desc = 'Toggle spell check' })

  -- ============================================================================
  -- FOLDING
  -- ============================================================================

  -- Better folding shortcuts
  map('n', '<leader>uf', '<cmd>set foldmethod=expr<cr>', { desc = 'Enable treesitter folding' })
  map('n', 'zR', '<cmd>set foldlevel=99<cr>', { desc = 'Open all folds' })
  map('n', 'zM', '<cmd>set foldlevel=0<cr>', { desc = 'Close all folds' })

  -- ============================================================================
  -- THEME TOGGLE
  -- ============================================================================
  
  map('n', '<leader>ut', function()
    if _G.toggle_color_theme then
      _G.toggle_color_theme()
    else
      vim.notify("Theme toggle not available", vim.log.levels.ERROR)
    end
  end, { desc = '[U]tility [T]heme toggle (Latte ↔ NGE)' })
end

-- Setup keymaps when this file is loaded
setup_keymaps()

return {}

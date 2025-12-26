return {
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
      { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
      { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
      { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
      { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
      { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
      { 'gco', mode = 'n', desc = 'Comment insert below' },
      { 'gcO', mode = 'n', desc = 'Comment insert above' },
      { 'gcA', mode = 'n', desc = 'Comment insert end of line' },
    },
    config = function()
      -- NORMAL mode
      -- `gcc` - Toggles the current line using linewise comment
      -- `gbc` - Toggles the current line using blockwise comment
      -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
      -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
      -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
      -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

      -- `gco` - Insert comment to the next line and enters INSERT mode
      -- `gcO` - Insert comment to the previous line and enters INSERT mode
      -- `gcA` - Insert comment to end of the current line and enters INSERT mode

      -- VISUAL mode
      -- `gc` - Toggles the region using linewise comment
      -- `gb` - Toggles the region using blockwise comment

      require('Comment').setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = 'gcc',
          ---Block-comment toggle keymap
          block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = 'gcO',
          ---Add comment on the line below
          below = 'gco',
          ---Add comment at the end of line
          eol = 'gcA',
        },
        ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },
        ---Lines to be ignored while (un)comment
        -- ignore = nil,
        ---Function to call before (un)comment
        -- pre_hook = nil,
        ---Function to call after (un)comment
        -- post_hook = nil,
      })
    end,
  },
  {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    {
      '[C',
      function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end,
      desc = 'Jump to context (upwards)',
    },
    { '<leader>tc', '<cmd>TSContext toggle<cr>', desc = 'Toggle Treesitter Context' },
  },
  opts = {
    enable = true,
    multiwindow = false,
    max_lines = 2,
    min_window_height = 25,
    line_numbers = false,
    multiline_threshold = 15,
    trim_scope = 'outer',
    mode = 'cursor',
    throttle = true,
    separator = nil,
    zindex = 20,
    on_attach = function(buf)
      local filetype = vim.bo[buf].filetype
      local disabled_filetypes = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
      }

      return not vim.tbl_contains(disabled_filetypes, filetype)
    end,
  },
  config = function(_, opts)
    require('treesitter-context').setup(opts)
    local colors = {
      base = '#eff1f5', -- Catppuccin latte base
      mantle = '#e6e9ef', -- Catppuccin latte mantle
      surface0 = '#ccd0da', -- Catppuccin latte surface0
      surface1 = '#bcc0cc', -- Catppuccin latte surface1
      surface2 = '#acb0be', -- Catppuccin latte surface2
      overlay0 = '#9ca0b0', -- Catppuccin latte overlay0
      overlay1 = '#8c8fa1', -- Catppuccin latte overlay1
      blue = '#1e66f5', -- Catppuccin latte blue
      lavender = '#7287fd', -- Catppuccin latte lavender
      text = '#4c4f69', -- Catppuccin latte text
      subtext0 = '#6c6f85', -- Catppuccin latte subtext0
    }

    -- Main context window styling with subtle gradient effect
    vim.api.nvim_set_hl(0, 'TreesitterContext', {
      bg = colors.surface0,
      fg = colors.text,
    })

    -- Line numbers with enhanced visibility
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
      bg = colors.surface0,
      fg = colors.overlay1,
      italic = true,
    })

    -- Separator with gradient-like appearance
    vim.api.nvim_set_hl(0, 'TreesitterContextSeparator', {
      fg = colors.lavender,
      bg = colors.surface0,
    })

    -- Enhanced bottom border with subtle glow effect
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
      bg = colors.surface0,
      sp = colors.blue,
      underline = true,
    })

    -- Bottom line numbers with matching underline
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', {
      bg = colors.surface0,
      fg = colors.overlay1,
      sp = colors.blue,
      underline = true,
      italic = true,
    })
  end,
},
{
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    after = 'nvim-treesitter',
    keys = {
      { 'am', mode = { 'x', 'o' }, desc = 'Select [A]round [M]ethod' },
      { 'im', mode = { 'x', 'o' }, desc = 'Select [I]nside [M]ethod' },
      { 'ac', mode = { 'x', 'o' }, desc = 'Select [A]round [C]lass' },
      { 'ic', mode = { 'x', 'o' }, desc = 'Select [I]nside [C]lass' },
      { 'aa', mode = { 'x', 'o' }, desc = 'Select [A]round P[a]rameter' },
      { 'ia', mode = { 'x', 'o' }, desc = 'Select [I]nside P[a]rameter' },
      { 'ab', mode = { 'x', 'o' }, desc = 'Select [A]round [B]lock' },
      { 'ib', mode = { 'x', 'o' }, desc = 'Select [I]nside [B]lock' },
      { ']m', desc = 'Next [m]ethod start' },
      { '[m', desc = 'Previous [m]ethod start' },
      { ']M', desc = 'Next [M]ethod end' },
      { '[M', desc = 'Previous [M]ethod end' },
      { ']]', desc = 'Next class start' },
      { '[[', desc = 'Previous class start' },
      { '][', desc = 'Next class end' },
      { '[]', desc = 'Previous class end' },
      { ']a', desc = 'Next p[a]rameter start' },
      { '[a', desc = 'Previous p[a]rameter start' },
      { ']A', desc = 'Next p[A]rameter end' },
      { '[A', desc = 'Previous p[A]rameter end' },
      { ']b', desc = 'Next [b]lock start' },
      { '[b', desc = 'Previous [b]lock start' },
      { ']B', desc = 'Next [B]lock end' },
      { '[B', desc = 'Previous [B]lock end' },
      { '<leader>wa', desc = 'S[w]ap p[a]rameter with next' },
      { '<leader>wA', desc = 'S[w]ap p[A]rameter with previous' },
      { '<leader>wm', desc = 'S[w]ap [M]ethod with next' },
      { '<leader>wM', desc = 'S[w]ap [M]ethod with previous' },
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              ['am'] = { query = '@function.outer', desc = 'Select [A]round [M]ethod' },
              ['im'] = { query = '@function.inner', desc = 'Select [I]nside [M]ethod' },
              ['ac'] = { query = '@class.outer', desc = 'Select [A]round [C]lass' },
              ['ic'] = { query = '@class.inner', desc = 'Select [I]nside [C]lass' },
              ['aa'] = { query = '@parameter.outer', desc = 'Select [A]round P[a]rameter' },
              ['ia'] = { query = '@parameter.inner', desc = 'Select [I]nside P[a]rameter' },
              ['ab'] = { query = '@block.outer', desc = 'Select [A]round [B]lock' },
              ['ib'] = { query = '@block.inner', desc = 'Select [I]nside [B]lock' },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = { query = '@function.outer', desc = 'Next [m]ethod start' },
              [']]'] = { query = '@class.outer', desc = 'Next class start' },
              [']a'] = { query = '@parameter.outer', desc = 'Next p[a]rameter start' },
              [']b'] = { query = '@block.outer', desc = 'Next [b]lock start' },
            },
            goto_next_end = {
              [']M'] = { query = '@function.outer', desc = 'Next [M]ethod end' },
              [']['] = { query = '@class.outer', desc = 'Next class end' },
              [']A'] = { query = '@parameter.outer', desc = 'Next p[A]rameter end' },
              [']B'] = { query = '@block.outer', desc = 'Next [B]lock end' },
            },
            goto_previous_start = {
              ['[m'] = { query = '@function.outer', desc = 'Previous [m]ethod start' },
              ['[['] = { query = '@class.outer', desc = 'Previous class start' },
              ['[a'] = { query = '@parameter.outer', desc = 'Previous p[a]rameter start' },
              ['[b'] = { query = '@block.outer', desc = 'Previous [b]lock start' },
            },
            goto_previous_end = {
              ['[M'] = { query = '@function.outer', desc = 'Previous [M]ethod end' },
              ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
              ['[A'] = { query = '@parameter.outer', desc = 'Previous p[A]rameter end' },
              ['[B'] = { query = '@block.outer', desc = 'Previous [B]lock end' },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>wa'] = { query = '@parameter.inner', desc = 'S[w]ap p[a]rameter with next' },
              ['<leader>wm'] = { query = '@function.outer', desc = 'S[w]ap [m]ethod with next' },
            },
            swap_previous = {
              ['<leader>wA'] = { query = '@parameter.inner', desc = 'S[w]ap p[A]rameter with previous' },
              ['<leader>wM'] = { query = '@function.outer', desc = 'S[w]ap [M]ethod with previous' },
            },
          },
        },
      }
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    keys = {
      { '<leader>sR', '<cmd>GrugFar<CR>', desc = '[S]earch and [R]eplace' },
      { '<leader>sW', function()
        require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
      end, desc = '[S]earch and replace current [W]ord' },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },
    {
    'HiPhish/rainbow-delimiters.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow', 
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async' },
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
      { 'zr', function() require('ufo').openFoldsExceptKinds() end, desc = 'Fold less' },
      { 'zm', function() require('ufo').closeFoldsWith() end, desc = 'Fold more' },
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    },
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },
  {
      'kylechui/nvim-surround',
      version = '*',
      keys = {
          -- Add surrounding in normal mode
          { 'ys', mode = 'n', desc = 'Surround: Add (with motion, e.g. ysiw")' },
          { 'yss', mode = 'n', desc = 'Surround: Add to entire line' },
          { 'yS', mode = 'n', desc = 'Surround: Add with newlines (with motion)' },
          { 'ySS', mode = 'n', desc = 'Surround: Add with newlines to entire line' },
          -- Modify surrounding
          { 'ds', mode = 'n', desc = 'Surround: Delete (e.g. ds")' },
          { 'cs', mode = 'n', desc = 'Surround: Change (e.g. cs)] changes () to [])' },
          { 'cS', mode = 'n', desc = 'Surround: Change with newlines' },
          -- Add surrounding in visual mode
          { 'S', mode = 'x', desc = 'Surround: Add to selection' },
          { 'gS', mode = 'x', desc = 'Surround: Add to selection with newlines' },
      },
      opts = {
          keymaps = {
              insert = "<C-g>s",
              insert_line = "<C-g>S",
              normal = "ys",
              normal_cur = "yss",
              normal_line = "yS",
              normal_cur_line = "ySS",
              visual = "S",
              visual_line = "gS",
              delete = "ds",
              change = "cs",
              change_line = "cS",
          },
      },
  },
  {
    'Wansmer/treesj',
    keys = {
      { 'gS', function() require('treesj').split() end, desc = 'Split node under cursor' },
      { 'gJ', function() require('treesj').join() end, desc = 'Join node under cursor' },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 120,
    },
  },
}

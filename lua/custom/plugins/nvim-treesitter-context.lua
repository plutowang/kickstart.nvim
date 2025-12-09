return {
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
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false, -- Enable multiwindow support.
    max_lines = 4, -- Limit context lines for better performance and screen real estate
    min_window_height = 20, -- Only enable when window is reasonably tall
    line_numbers = true,
    multiline_threshold = 15, -- Reduced for better readability
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil, -- Use a subtle horizontal line separator
    zindex = 20, -- The Z-index of the context window
    on_attach = function(buf)
      -- Disable for specific file types for better performance
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

    -- Enhanced color palette for better contrast and readability
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
}


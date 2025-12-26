-- Enhanced motion and navigation plugins
-- Improve cursor movement and navigation without performance overhead

return {
  -- Show available motions as virtual text hints
  {
    'tris203/precognition.nvim',
    keys = {
      { '<leader>tp', '<cmd>Precognition toggle<cr>', desc = '[T]oggle [P]recognition hints' },
    },
    opts = {
      startVisible = false, -- Start with hints disabled
      showBlankVirtLine = true,
      highlightColor = { link = 'Comment' },
      hints = {
        Caret = { text = '^', prio = 2 },
        Dollar = { text = '$', prio = 1 },
        MatchingPair = { text = '%', prio = 5 },
        Zero = { text = '0', prio = 1 },
        w = { text = 'w', prio = 10 },
        b = { text = 'b', prio = 9 },
        e = { text = 'e', prio = 8 },
        W = { text = 'W', prio = 7 },
        B = { text = 'B', prio = 6 },
        E = { text = 'E', prio = 5 },
      },
    },
  },

  -- Smart tab out of brackets, quotes, etc.
  {
    'abecodes/tabout.nvim',
    event = 'InsertEnter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      tabkey = '<Tab>',
      backwards_tabkey = '<S-Tab>',
      act_as_tab = true,
      act_as_shift_tab = false,
      default_tab = '<C-t>',
      default_shift_tab = '<C-d>',
      enable_backwards = true,
      completion = false, -- Don't interfere with completion
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = '`', close = '`' },
        { open = '(', close = ')' },
        { open = '[', close = ']' },
        { open = '{', close = '}' },
        { open = '<', close = '>' },
      },
    },
  },
}
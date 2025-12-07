return {
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
      { '<leader>sa', desc = '[S]wap p[a]rameter with next' },
      { '<leader>sA', desc = '[S]wap p[A]rameter with previous' },
      { '<leader>sm', desc = '[S]wap [M]ethod with next' },
      { '<leader>sM', desc = '[S]wap [M]ethod with previous' },
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
              ['<leader>sa'] = { query = '@parameter.inner', desc = '[S]wap p[a]rameter with next' },
              ['<leader>sm'] = { query = '@function.outer', desc = '[S]wap [M]ethod with next' },
            },
            swap_previous = {
              ['<leader>sA'] = { query = '@parameter.inner', desc = '[S]wap p[A]rameter with previous' },
              ['<leader>sM'] = { query = '@function.outer', desc = '[S]wap [M]ethod with previous' },
            },
          },
        },
      }
    end,
  },
}

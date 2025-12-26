-- Quality of Life improvements
-- Small utilities that improve the editing experience without performance impact

return {
  -- Intelligently restore cursor position when reopening files
  {
    'nxhung2304/lastplace.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
      lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
      lastplace_open_folds = true,
    },
  },

  -- Automatically create missing directories when saving files
  {
    'jghauser/mkdir.nvim',
    event = 'BufWritePre',
    config = true,
  },
}
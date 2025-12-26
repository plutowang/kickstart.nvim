return {
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>uu', '<cmd>UndotreeToggle<cr>', desc = '[U]ndotree toggle' },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    'chrisgrieser/nvim-genghis',
    keys = {
      { '<leader>fr', function() require('genghis').renameFile() end, desc = '[F]ile [R]ename' },
      { '<leader>fd', function() require('genghis').duplicateFile() end, desc = '[F]ile [D]uplicate' },
      { '<leader>fn', function() require('genghis').createNewFile() end, desc = '[F]ile [N]ew' },
      { '<leader>fx', function() require('genghis').moveAndRenameFile() end, desc = '[F]ile move and rename' },
      { '<leader>fc', function() require('genghis').copyFilepath() end, desc = '[F]ile path [C]opy' },
    },
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    keys = {
      { '<leader>us', function() require('persistence').load() end, desc = '[U]tility [S]ession restore' },
      { '<leader>ul', function() require('persistence').load({ last = true }) end, desc = '[U]tility [L]ast session' },
      { '<leader>ud', function() require('persistence').stop() end, desc = "[U]tility session [D]on't save" },
    },
    opts = {
      options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' },
    },
  },
}
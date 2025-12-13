return {
  'folke/snacks.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- Disabled features
    git = { enabled = false },
    dashboard = { enabled = false },
    notifier = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    styles = { enabled = false },
    scratch = { enabled = false },
    rename = { enabled = false },
    animate = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    picker = { enabled = false },
    scope = { enabled = false },
    toggle = { enabled = false },
    win = { enabled = false },
    zen = { enabled = false },

    -- Enabled features
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    lazygit = { enabled = true },
    scroll = { enabled = true },
    bufdelete = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        style = 'terminal',
        position = 'float',
        border = 'rounded',
        title_pos = 'center',
        footer_pos = 'center',
        width = 0.8,
        height = 0.8,
        row = 0.1,
        col = 0.1,
        backdrop = 60,
        zindex = 50,
        wo = {
          winblend = 10,
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,FloatTitle:FloatTitle',
        },
      },
    },
    gitbrowse = {
      enabled = true,
      notify = true,
      open = function(url)
        if vim.fn.has 'mac' == 1 then
          vim.fn.system("open '" .. url .. "'")
        elseif vim.fn.has 'unix' == 1 then
          vim.fn.system("xdg-open '" .. url .. "'")
        else
          vim.fn.system("start '" .. url .. "'")
        end
      end,
      remote = 'origin',
      branch = nil,
    },
  },
  keys = {
    -- Git browsing
    {
      '<leader>gb',
      function()
        Snacks.gitbrowse()
      end,
      desc = '[G]it [b]rowse',
    },
    {
      '<leader>gB',
      function()
        Snacks.git.blame_line()
      end,
      desc = '[G]it [B]lame Line',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = '[G]it [L]og',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'Lazy [G]it',
    },

    -- Buffer operations
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = '[B]uffer [D]elete',
    },
    {
      '<leader>bD',
      function()
        Snacks.bufdelete.delete()
      end,
      desc = '[B]uffer [D]elete Force',
    },
    {
      '<leader>bO',
      function()
        Snacks.bufdelete.other()
      end,
      desc = '[B]uffer Delete [O]thers',
    },
    {
      '<leader>ba',
      function()
        Snacks.bufdelete.all()
      end,
      desc = '[B]uffer Delete [A]ll',
    },

    -- Terminal operations
    {
      '<leader>tt',
      function()
        Snacks.terminal()
      end,
      desc = '[T]erminal',
    },
    {
      '<leader>tf',
      function()
        Snacks.terminal(nil, { win = { position = 'float' } })
      end,
      desc = '[T]erminal [F]loat',
    },
    {
      '<leader>tp',
      function()
        Snacks.terminal('python3', { win = { position = 'float' } })
      end,
      desc = '[T]erminal [P]ython REPL',
    },
    {
      '<leader>to',
      function()
        Snacks.terminal('node', { win = { position = 'float' } })
      end,
      desc = '[T]erminal N[o]de REPL',
    },
    {
      '<leader>ts',
      function()
        Snacks.scratch()
      end,
      desc = '[T]erminal [S]cratch Buffer',
    },
    {
      '<leader>tS',
      function()
        Snacks.scratch.select()
      end,
      desc = '[T]oggle [S]elect Scratch Buffer',
      mode = { 'n', 'v' },
    },

    -- File operations
    {
      '<leader>ur',
      function()
        Snacks.rename.rename_file()
      end,
      desc = '[R]ename File',
    },
  },
}


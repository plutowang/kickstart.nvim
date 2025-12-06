return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'lawrence-laz/neotest-zig',
      'fredrikaverpil/neotest-golang',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>rt', '', desc = '+test' },
      {
        '<leader>rtt',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run File (Neotest)',
      },
      {
        '<leader>rtT',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'Run All Test Files (Neotest)',
      },
      {
        '<leader>rtr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest (Neotest)',
      },
      {
        '<leader>rtl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run Last (Neotest)',
      },
      {
        '<leader>rts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Summary (Neotest)',
      },
      {
        '<leader>rto',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show Output (Neotest)',
      },
      {
        '<leader>rtO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel (Neotest)',
      },
      {
        '<leader>rtS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop (Neotest)',
      },
      {
        '<leader>rtw',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = 'Toggle Watch (Neotest)',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          -- Registration
          require 'neotest-zig' {
            dap = {
              adapter = 'lldb',
            },
          },
          require 'neotest-golang' {},
        },
        status = { virtual_text = true },
        output = { open_on_run = true, close_on_exit = true },
        quickfix = {
          open = function()
            vim.cmd 'copen 10' -- Open quickfix window automatically
          end,
        },
      }
    end,
  },
}

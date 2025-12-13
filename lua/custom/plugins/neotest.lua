return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'lawrence-laz/neotest-zig',
      'fredrikaverpil/neotest-golang',
      'mrcjkb/rustaceanvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      -- Test Running
      {
        '<leader>rn',
        function()
          require('neotest').run.run()
        end,
        desc = '[R]un [N]earest test',
      },
      {
        '<leader>rf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[R]un [F]ile tests',
      },
      {
        '<leader>ra',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = '[R]un [A]ll tests',
      },
      {
        '<leader>rl',
        function()
          require('neotest').run.run_last()
        end,
        desc = '[R]un [L]ast test',
      },
      {
        '<leader>rs',
        function()
          require('neotest').run.stop()
        end,
        desc = '[R]un [S]top',
      },

      -- Test UI/Display
      {
        '<leader>rt',
        function()
          require('neotest').summary.toggle()
        end,
        desc = '[R]un [T]oggle summary',
      },
      {
        '<leader>ro',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = '[R]un [O]utput show',
      },
      {
        '<leader>rO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = '[R]un [O]utput panel toggle',
      },

      -- Test Watch
      {
        '<leader>rw',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = '[R]un [W]atch toggle',
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
          require 'neotest-golang' {
              -- disable test caching
              extra_args = { "-count=1" },
          },
          require 'rustaceanvim.neotest',
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

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'lawrence-laz/neotest-zig',
      'fredrikaverpil/neotest-golang',
      'mrcjkb/rustaceanvim',
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '<leader>rt',
        function()
          require('neotest').run.run()
        end,
        desc = '[R]un Nearest [T]est',
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
        '<leader>rS',
        function()
          require('neotest').summary.toggle()
        end,
        desc = '[R]un Toggle [S]ummary',
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
        desc = '[R]un Toggle [O]utput Panel',
      },
      {
          '<leader>rC',
          function()
              require('neotest').output_panel.clear()
          end,
          desc = '[R]un [C]lear Output Panel',
      },
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
          -- TODO: issue with zig v0.15
          -- https://github.com/lawrence-laz/neotest-zig/issues/41
          require 'neotest-zig' {
            dap = {
              adapter = 'lldb',
            },
          },
          require 'neotest-golang' {
              -- disable test caching
              extra_args = { "-count=1" },
              warn_test_name_dupes = false,
          },
          require 'neotest-jest' {
            jestCommand = "pnpm test --",
            jestConfigFile = function(file)
              local pkg = file:match("(.*/[^/]+/)src")
              if pkg then
                return pkg .. "jest.config.ts"
              end
              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
            cwd = function(file)
              local pkg = file:match("(.*/[^/]+/)src")
              return pkg or vim.fn.getcwd()
            end,
            env = { CI = true },
          },
          require 'neotest-vitest' {
            vitestCommand = "pnpm vitest",
            cwd = function(file)
              return vim.fn.getcwd()
            end,
            env = { CI = true },
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
        discovery = { enabled = true },
        diagnostic = { enabled = true },
      }
    end,
  },
}

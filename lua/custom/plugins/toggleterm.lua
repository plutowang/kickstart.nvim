return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {
      '<leader>tt',
      function()
        require('toggleterm').toggle(1, 0, vim.loop.cwd(), 'horizontal')
      end,
      desc = '[T]oggle [T]erminal Horizontal',
    },
    {
      '<leader>tv',
      function()
        require('toggleterm').toggle(1, 0, vim.loop.cwd(), 'vertical')
      end,
      desc = '[T]erminal [V]ertical',
    },
    {
      '<leader>tf',
      function()
        require('toggleterm').toggle(2, 0, vim.loop.cwd(), 'float')
      end,
      desc = '[T]erminal [F]loat',
    },
    {
      '<leader>ts',
      function()
        require('toggleterm').send_lines_to_terminal('single_line', true, {
          args = vim.v.count,
        })
      end,
      desc = '[T]erminal [S]end lines',
    },
    {
      '<leader>ta',
      '<cmd>ToggleTermToggleAll<cr>',
      desc = '[T]erminal Toggle [A]ll',
    },
    {
      '<leader>tn',
      '<cmd>TermNew<cr>',
      desc = '[T]erminal [N]ew',
    },
    {
      '<leader>tl',
      '<cmd>TermSelect<cr>',
      desc = '[T]erminal Se[l]ect',
    },
    {
      '<leader>tr',
      function()
        local cmd = vim.fn.input 'Command: '
        if cmd ~= '' then
          require('toggleterm').exec(cmd, vim.v.count1, 12)
        end
      end,
      desc = '[T]erminal [R]un command',
    },
    {
      '<leader>tk',
      function()
        require('toggleterm').exec('clear', vim.v.count1, 12)
      end,
      desc = '[T]erminal Clear (K)',
    },
    {
      '<leader>tg',
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new {
          cmd = 'lazygit',
          direction = 'float',
          float_opts = {
            border = 'rounded',
            width = function()
              return math.floor(vim.o.columns * 0.9)
            end,
            height = function()
              return math.floor(vim.o.lines * 0.9)
            end,
          },
          on_open = function(term)
            vim.cmd 'startinsert!'
            vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', {
              noremap = true,
              silent = true,
            })
          end,
        }
        lazygit:toggle()
      end,
      desc = '[T]erminal La[z]y[g]it',
    },
    {
      '<leader>th',
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        local htop = Terminal:new {
          cmd = 'htop',
          direction = 'float',
          float_opts = {
            border = 'rounded',
          },
          on_open = function(term)
            vim.cmd 'startinsert!'
            vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', {
              noremap = true,
              silent = true,
            })
          end,
        }
        htop:toggle()
      end,
      desc = '[T]erminal [H]top',
    },
    {
      '<leader>tp',
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        local python = Terminal:new {
          cmd = 'python3',
          direction = 'float',
          float_opts = {
            border = 'rounded',
          },
          on_open = function(term)
            vim.cmd 'startinsert!'
          end,
        }
        python:toggle()
      end,
      desc = '[T]erminal [P]ython REPL',
    },
    {
      '<leader>to',
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        local node = Terminal:new {
          cmd = 'node',
          direction = 'float',
          float_opts = {
            border = 'rounded',
          },
          on_open = function(term)
            vim.cmd 'startinsert!'
          end,
        }
        node:toggle()
      end,
      desc = '[T]erminal N[o]de REPL',
    },
    {
      '<leader>td',
      function()
        local dir = vim.fn.input('Directory: ', vim.fn.getcwd(), 'dir')
        if dir ~= '' then
          vim.cmd('ToggleTerm dir=' .. dir)
        end
      end,
      desc = '[T]erminal with [D]irectory',
    },
    {
      '<leader>te',
      function()
        local cmd = vim.fn.input 'Execute: '
        local term_id = vim.fn.input 'Terminal ID (default 1): '
        if cmd ~= '' then
          local id = tonumber(term_id) or 1
          vim.cmd('TermExec cmd="' .. cmd .. '" ' .. id)
        end
      end,
      desc = '[T]erminal [E]xecute command',
    },
    {
      '<leader>tw',
      function()
        local name = vim.fn.input 'Terminal name: '
        if name ~= '' then
          vim.cmd('ToggleTermSetName ' .. name)
        end
      end,
      desc = '[T]erminal Set name ([W]indow title)',
    },
  },
  config = function()
    require('toggleterm').setup {
      shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      direction = 'float',
      float_opts = {
        border = 'rounded',
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 3,
        col = function()
          return math.floor((vim.o.columns - (vim.o.columns * 0.85)) / 2)
        end,
        row = function()
          return math.floor((vim.o.lines - (vim.o.lines * 0.8)) / 2)
        end,
        highlights = {
          border = 'FloatBorder',
          background = 'NormalFloat',
        },
      },
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      highlights = {
        Normal = {
          guibg = 'NONE',
        },
        NormalFloat = {
          link = 'NormalFloat',
        },
        FloatBorder = {
          link = 'FloatBorder',
        },
      },
    }
  end,
}

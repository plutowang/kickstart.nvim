return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require 'toggleterm'
    -- set keymaps
    vim.keymap.set('n', '<leader>tt', function()
      toggleterm.toggle(1, 0, vim.loop.cwd(), 'horizontal')
    end, { desc = 'Horizontal Terminal' })
    vim.keymap.set('n', '<leader>tf', function()
      toggleterm.toggle(1, 0, vim.loop.cwd(), 'float')
    end, { desc = 'Float Terminal' })
    vim.keymap.set('n', '<leader>tv', function()
      toggleterm.toggle(1, 0, vim.loop.cwd(), 'vertical')
    end, { desc = 'Vertical Terminal' })
    vim.keymap.set('v', '<space>sl', function()
      require('toggleterm').send_lines_to_terminal('single_line', trim_spaces, { args = vim.v.count })
    end)

    require('toggleterm').setup {
      shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      size = 10,
      direction = 'float',
      float_opts = {
        border = 'curved',
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    }
  end,
}

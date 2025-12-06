return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      { 'lewis6991/gitsigns.nvim', optional = true },
      { 'nvim-tree/nvim-web-devicons', optional = true },
    },
    event = 'BufAdd', -- Load when first buffer is added
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)

      map('n', '<leader>od', '<Cmd>BufferOrderByDirectory<CR>', opts)
      map('n', '<leader>ol', '<Cmd>BufferOrderByLanguage<CR>', opts)

      map('n', '<C-h>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<C-l>', '<Cmd>BufferNext<CR>', opts)
      map('n', '<C-x>', '<Cmd>BufferClose<CR>', opts)
      map('n', '<A-h>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A-l>', '<Cmd>BufferMoveNext<CR>', opts)
      require('barbar').setup {
        animation = true,
        no_name_title = '[No Name]',
        insert_at_end = true,
        exclude_name = { '[dap-repl]' },
        exclude_ft = { 'qf' },
        maximum_length = 60,
        hide = { extensions = false },
        icons = {
          button = false,
          preset = 'default',
          filetype = {
            custom_colors = true,
            enabled = vim.g.have_nerd_font,
          }
        },
      }
    end,
  }
}

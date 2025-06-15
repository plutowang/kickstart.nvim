return {
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    ft = { 'html', 'typescriptreact', 'javascriptreact' },
    config = function()
      require('tailwindcss-colorizer-cmp').setup {
        color_square_width = 1,
      }
    end,
  },
}

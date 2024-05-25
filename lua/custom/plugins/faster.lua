return {
  {
    'pteroctopus/faster.nvim',
    lazy = true,
    config = function()
      require('faster').setup()
    end,
  }
}

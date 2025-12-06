return {
  {
    'vhyrro/luarocks.nvim',
    enabled = function()
      if vim.fn.has 'win32' == 1 then
        return false
      end
      return true
    end,
    ft = "http",
    priority = 1000,
    config = true,
    opts = {
      rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
    },
  }
}

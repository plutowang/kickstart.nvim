return {
  'vhyrro/luarocks.nvim',
  ft = "http",
  priority = 1000,
  config = true,
  opts = {
    rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
  },
}

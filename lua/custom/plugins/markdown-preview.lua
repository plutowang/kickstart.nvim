return {
  {
    'iamcco/markdown-preview.nvim',
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.cmd [[do FileType]]
    end,
  }
}

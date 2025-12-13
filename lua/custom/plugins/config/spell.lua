-- Optimized spell checking configuration
-- Load spell checking only for relevant filetypes to improve startup performance

-- Configure spell checking via autocmd
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'gitcommit', 'NeogitCommitMessage' },
  callback = function()
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.spell = true
  end,
})

return {}
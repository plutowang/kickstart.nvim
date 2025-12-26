  -- ============================================================================
  -- EXPERIMENTAL PLUGINS TOGGLE
  -- ============================================================================
  
  vim.keymap.set('n', '<leader>ue', function()
    vim.g.experimental_enabled = not vim.g.experimental_enabled
    local status = vim.g.experimental_enabled and "ENABLED" or "DISABLED"
    vim.notify("Experimental plugins " .. status .. " (reloading...)", vim.log.levels.INFO)

    -- Refresh lualine to show indicator immediately
    if package.loaded['lualine'] then
      require('lualine').refresh()
    end
    
    -- Use Lazy sync and notify for manual install
    if vim.g.experimental_enabled then
      vim.cmd('Lazy sync')
      vim.defer_fn(function()
        vim.notify("Press 'I' in Lazy window to install experimental plugins", vim.log.levels.INFO)
      end, 3000)
    else
      vim.cmd('Lazy sync')
    end
  end, { desc = '[U]tility [E]xperimental plugins toggle' })
-- ============================================================================

-- Toggle experimental plugins with <leader>ue
-- Default: DISABLED
if vim.g.experimental_enabled ~= true then
  return {}
end

return {
    { import = 'custom.plugins.experimental.enhanced-editing' },
    { import = 'custom.plugins.experimental.smart-navigation' },
    { import = 'custom.plugins.experimental.quality-of-life' },
    { import = 'custom.plugins.experimental.enhanced-motions' },
    { import = 'custom.plugins.experimental.lsp-enhancements' },
}
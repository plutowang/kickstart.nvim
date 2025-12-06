-- ============================================================================
-- NEOVIM PERFORMANCE & UX OPTIMIZATIONS
-- Additional settings for kickstart.nvim
-- Place this BEFORE lazy.nvim plugin setup in your init.lua
-- ============================================================================
-- Enable faster Lua module loading (Neovim 0.9+)
if vim.loader then
    vim.loader.enable()
end

-- ============================================================================
-- PERFORMANCE OPTIMIZATIONS
-- ============================================================================
vim.opt.ttimeoutlen = 10 -- Faster escape key response
vim.opt.synmaxcol = 200 -- Don't highlight lines longer than 200 chars

-- File operations
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Disable backup during write
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.undolevels = 10000 -- More undo history

-- ============================================================================
-- UI ENHANCEMENTS
-- ============================================================================
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right
vim.opt.pumheight = 10 -- Limit popup menu height
vim.opt.termguicolors = true -- True color support

-- ============================================================================
-- FOLDING (requires nvim-treesitter)
-- ============================================================================
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99

-- ============================================================================
-- DISABLE UNUSED BUILTIN PLUGINS
-- ============================================================================
local disabled_built_ins = { -- Archive formats (rarely needed)
'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin', -- Other unused plugins
'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', 'rrhelper', 'spellfile_plugin'}

for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end
return {}

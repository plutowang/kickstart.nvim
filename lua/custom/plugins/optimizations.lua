-- ============================================================================
-- NEOVIM PERFORMANCE & UX OPTIMIZATIONS
-- Additional settings for kickstart.nvim
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
vim.opt.redrawtime = 1500 -- Stop highlighting if it takes too long
vim.opt.maxmempattern = 5000 -- Increase memory for pattern matching

-- File operations
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Disable backup during write
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.undolevels = 10000 -- More undo history
vim.opt.history = 1000 -- More command history

-- Faster macro playback
vim.opt.lazyredraw = true -- Don't redraw during macros

-- ============================================================================
-- UI ENHANCEMENTS
-- ============================================================================
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right
vim.opt.pumheight = 15 -- Limit popup menu height
vim.opt.termguicolors = true -- True color support
vim.opt.pumblend = 10 -- Slightly transparent popup menu
vim.opt.winblend = 0 -- No transparency for floating windows by default

-- Better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append 'c'

-- ============================================================================
-- FOLDING (requires nvim-treesitter)
-- ============================================================================
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4 -- Limit fold nesting

-- ============================================================================
-- SEARCH & REPLACE ENHANCEMENTS
-- ============================================================================
vim.opt.gdefault = true -- Global replace by default
vim.opt.inccommand = 'nosplit' -- Show effects of substitute command incrementally

local disabled_built_ins = {
  -- Archive formats (rarely needed)
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  -- Network/remote plugins (use modern alternatives)
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  -- Other unused plugins
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
  -- Health check (can be manually run when needed)
  'health',
  'man',
  'tutor_mode_plugin',
  -- Additional plugins for faster startup
  '2html_plugin',
  'tohtml',
  'logipat',
  'compiler',
  'bugreport',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
return {}

-- ============================================================================
-- NEOVIM PERFORMANCE & UX OPTIMIZATIONS  
-- Additional settings for kickstart.nvim
-- ============================================================================

-- ============================================================================
-- PERFORMANCE OPTIMIZATIONS
-- ============================================================================
-- Only set absolutely essential options immediately
vim.opt.ttimeoutlen = 10 -- Faster escape key response  
vim.opt.lazyredraw = true -- Faster macro playback
vim.opt.swapfile = false -- No swap files
vim.opt.backup = false -- No backup files

-- Defer non-critical options to after startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Performance settings that can wait
    vim.opt.synmaxcol = 150
    vim.opt.redrawtime = 1000
    vim.opt.maxmempattern = 3000
    vim.opt.re = 0
    vim.opt.regexpengine = 1
    
    -- File operations
    vim.opt.writebackup = false
    vim.opt.hidden = true
    vim.opt.undolevels = 10000
    vim.opt.history = 1000
    vim.opt.updatetime = 200
    vim.opt.timeoutlen = 300

    -- UI enhancements (deferred)
    vim.opt.wrap = false -- Don't wrap long lines
    vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right
    vim.opt.pumheight = 15 -- Limit popup menu height
    vim.opt.termguicolors = true -- True color support
    vim.opt.pumblend = 10 -- Slightly transparent popup menu
    vim.opt.winblend = 0 -- No transparency for floating windows
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.opt.pumwidth = 30
  end,
})
vim.opt.shortmess:append 'c'

-- ============================================================================
-- FOLDING
-- ============================================================================
vim.opt.foldmethod = 'indent' -- Use faster indent folding
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 3 -- Limit fold nesting for performance
vim.opt.foldenable = true

-- ============================================================================
-- SEARCH & REPLACE ENHANCEMENTS
-- ============================================================================
vim.opt.gdefault = true -- Global replace by default
vim.opt.inccommand = 'nosplit' -- Show effects of substitute command incrementally

-- ============================================================================
-- DISABLE UNUSED VIM BUILT-INS FOR FASTER STARTUP
-- ============================================================================

-- Disable unused built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

-- Disable netrw (using modern file managers instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Disable other unused plugins
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_compiler = 1
vim.g.loaded_bugreport = 1
vim.g.loaded_optwin = 1
vim.g.loaded_syntax_completion = 1
vim.g.loaded_sql_completion = 1
vim.g.loaded_xmlformat = 1
vim.g.loaded_remote_plugins = 1

-- ============================================================================
-- FILE TYPE DETECTION PATCHING
-- ============================================================================
vim.filetype.add({
    pattern = {
        [".*/.*%.component%.html"] = "htmlangular",  -- matches *.component.html
    },
})

-- ============================================================================
-- AUTO-RELOAD & AUTO-SAVE
-- ============================================================================
-- Auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
-- Note: auto save is handled by okuuva/auto-save.nvim plugin in editor/buffers.lua
-- vim.o.autoread = true

-- -- Auto save configuration
-- vim.opt.autoread = true
-- vim.opt.autowrite = true
-- vim.opt.autowriteall = true
-- vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
--   callback = function()
--     if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
--       vim.api.nvim_command 'silent update'
--     end
--   end,
-- })

return {}

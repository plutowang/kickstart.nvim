return {{
    'ray-x/go.nvim',
    dependencies = {{
        'ray-x/guihua.lua',
        lazy = true
    }, 'neovim/nvim-lspconfig', 'nvim-treesitter/nvim-treesitter'},
    ft = {'go', 'gomod'},
    cmd = {'GoRun', 'GoBuild', 'GoTest', 'GoMod'},
    config = function(lp, opts)
        require('go').setup(opts)
    end,
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}}

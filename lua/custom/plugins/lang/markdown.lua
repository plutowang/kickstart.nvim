return {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {{
        'nvim-treesitter/nvim-treesitter',
        lazy = true
    }},
    opts = {
        file_types = {'markdown', 'Avante'},
        completions = {
            lsp = {
                enabled = true
            }
        }
    },
    ft = {'markdown', 'Avante'}
}

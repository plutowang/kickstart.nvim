return {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    ft = {'html', 'css', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'vue', 'svelte'},
    config = function()
        require('tailwindcss-colorizer-cmp').setup {
            color_square_width = 1
        }
    end
}

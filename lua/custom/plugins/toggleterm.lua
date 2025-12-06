return {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {{
        '<leader>tt',
        function()
            require('toggleterm').toggle(1, 0, vim.loop.cwd(), 'horizontal')
        end,
        desc = '[T]oggle [T]erminal Horizontal'
    }, {
        '<leader>tv',
        function()
            require('toggleterm').toggle(1, 0, vim.loop.cwd(), 'vertical')
        end,
        desc = 'Terminal [V]ertical '
    }, {
        '<leader>tf',
        function()
            require('toggleterm').toggle(2, 0, vim.loop.cwd(), 'float')
        end,
        desc = '[T]erminal [F]loat'
    }, {
        '<leader>ts',
        function()
            require('toggleterm').send_lines_to_terminal('single_line', trim_spaces, {
                args = vim.v.count
            })
        end,
        desc = '[T]erminal [S]ent lines'
    }},
    config = function()
        require('toggleterm').setup {
            shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            size = 10,
            direction = 'float',
            float_opts = {
                border = 'curved',
                highlights = {
                    border = 'Normal',
                    background = 'Normal'
                }
            }
        }
    end
}

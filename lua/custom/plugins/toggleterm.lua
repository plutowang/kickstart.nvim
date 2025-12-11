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
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            direction = 'float',
            float_opts = {
                border = 'rounded',
                width = function()
                    return math.floor(vim.o.columns * 0.85)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.8)
                end,
                winblend = 3,
                col = function()
                    return math.floor((vim.o.columns - (vim.o.columns * 0.85)) / 2)
                end,
                row = function()
                    return math.floor((vim.o.lines - (vim.o.lines * 0.8)) / 2)
                end,
                highlights = {
                    border = 'FloatBorder',
                    background = 'NormalFloat'
                }
            },
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            persist_mode = true,
            close_on_exit = true,
            shell = vim.o.shell,
            auto_scroll = true,
            highlights = {
                Normal = {
                    guibg = 'NONE'
                },
                NormalFloat = {
                    link = 'NormalFloat'
                },
                FloatBorder = {
                    link = 'FloatBorder'
                }
            }
        }
    end
}

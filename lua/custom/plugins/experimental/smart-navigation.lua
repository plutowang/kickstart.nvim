return { -- Better file explorer alternative
{
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = {{
        '<leader>-',
        '<cmd>Oil<cr>',
        desc = 'Open Oil file explorer'
    }},
    opts = {
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
            natural_order = true
        },
        float = {
            padding = 2,
            max_width = 0.9,
            max_height = 0.9,
            border = 'rounded'
        }
    }
}, {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    opts = {
        keys = {{
            '>',
            function()
                require('quicker').expand({
                    before = 2,
                    after = 2,
                    add_to_existing = true
                })
            end,
            desc = 'Expand quickfix context'
        }, {
            '<',
            function()
                require('quicker').collapse()
            end,
            desc = 'Collapse quickfix context'
        }}
    }
}}

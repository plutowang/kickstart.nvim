return {
    'hrsh7th/nvim-cmp',
    optional = true,
    dependencies = {{
        'petertriho/cmp-git',
        opts = {}
    }, {
        'roobert/tailwindcss-colorizer-cmp.nvim',
        opts = {}
    }},
    event = 'InsertEnter',
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
        opts.formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(_, item)
                local icons = require("lazyvim.config").icons.kinds
                if icons[item.kind] then
                    item.kind = icons[item.kind]
                end
                return item
            end
        }
        -- table.insert(opts.sources, { name = 'git' })
        -- original LazyVim kind icon formatter
        local format_kinds = opts.formatting.format
        opts.formatting.format = function(entry, item)
            format_kinds(entry, item) -- add icons
            return require('tailwindcss-colorizer-cmp').formatter(entry, item)
        end
    end
}

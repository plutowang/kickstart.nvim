return {
    {
        -- Alternative to tailwindcss-colorizer-cmp for blink.cmp
        'NvChad/nvim-colorizer.lua',
        ft = { 'css', 'scss', 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        opts = {
            filetypes = { 'css', 'scss', 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = true, -- "Name" codes like Blue or blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = false, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes for `mode`: foreground, background, virtualtext
                mode = 'background', -- Set the display mode
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = 'both', -- Enable tailwind colors
                sass = {
                    enable = false
                }, -- Enable sass colors
                virtualtext = '■',
                always_update = false
            },
            -- all the sub-options of filetypes apply to buftypes
            buftypes = {}
        }
    },
    {
        -- Enhanced Tailwind CSS LSP support with better autocomplete
        'roobert/tailwindcss-colorizer-cmp.nvim',
        enabled = false -- Disabled since we're using blink.cmp
        -- Note: This plugin is specifically for nvim-cmp and doesn't work with blink.cmp
    }
}

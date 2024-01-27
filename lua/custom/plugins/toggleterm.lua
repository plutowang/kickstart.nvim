return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        {
            "<leader>tt",
            function()
                require("toggleterm").toggle(1, 0, vim.loop.cwd(), "horizontal")
            end,
            desc = "Horizontal Terminal",
        },
        {
            "<leader>t2",
            function()
                require("toggleterm").toggle(2, 0, vim.loop.cwd(), "horizontal")
            end,
            desc = "Horizontal Terminal",
        },
        {
            "<leader>tf",
            function()
                require("toggleterm").toggle(1, 0, vim.loop.cwd(), "float")
            end,
            desc = "Horizontal Terminal",
        },
        {
            "<leader>tv",
            function()
                require("toggleterm").toggle(1, 0, vim.loop.cwd(), "vertical")
            end,
            desc = "Vertical Terminal",
        },
        {
            "<leader>Tn",
            "<cmd>ToggleTermSetName<cr>",
            desc = "Set Terminal Name",
        },
        {
            "<leader>Ts",
            "<cmd>TermSelect<cr>",
            desc = "Select Terminal",
        },
    },
    config = function()
        require('toggleterm').setup({
            shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            size = 10,
            direction = "float",
            float_opts = {
                border = "curved",
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
    end,
}

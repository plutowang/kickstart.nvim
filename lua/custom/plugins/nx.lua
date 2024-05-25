return {
    {
        "plutowang/nx.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        after = "telescope",
        event = "VeryLazy",
        -- Plugin will load when you use these keys
        keys = {
            { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" },
            { "<leader>nm", "<cmd>Telescope nx run_many<CR>", desc = "nx actions run_many" },
            { "<leader>na", "<cmd>Telescope nx affected<CR>", desc = "nx actions affected" },
        },
        config = function(_, opts)
            require('nx').setup {
                -- Base command to run all other nx commands, some other values may be:
                -- - `npm nx`
                -- - `yarn nx`
                -- - `pnpm nx`
                nx_cmd_root = "pnpm nx",

                -- Command running capabilities,
                -- see nx.m.command-runners for more details
                command_runner = require("nx.command-runners").toggleterm_runner({
                    direction = 'float',
                    count = 10,
                    close_on_exit = false,
                }),
                -- Form rendering capabilities,
                -- see nx.m.form-renderers for more detials
                form_renderer = require("nx.form-renderers").telescope(),

                -- Whether or not to load nx configuration,
                -- see nx.loading-and-reloading for more details
                read_init = true,
            }
        end,

    },
}
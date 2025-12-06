return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      { "nvim-tree/nvim-web-devicons", lazy = true },
      { "MunifTanjim/nui.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>re",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = "/" })
        end,
        desc = "[R]oot [E]xplorer NeoTree",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "[F]ile [E]xplorer NeoTree",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "[G]it [E]xplorer NeoTree",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "[B]uffer [E]xplorer NeoTree",
      },
    },
    config = function()
      require('neo-tree').setup({
        auto_clean_after_session_restore = true,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              "node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              "*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              ".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
              "thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              ".null-ls_*",
            },
          },
        },
        close_if_last_window = false,
        enable_diagnostics = true,
        enable_git_status = true,
        popup_border_style = "rounded",
        sort_case_insensitive = false,
        window = {
          position = "left",
          width = "15%",
          auto_expand_width = false,
        },
      })
    end,
  }
}

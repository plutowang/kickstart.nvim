return {
    {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      { 'MunifTanjim/nui.nvim', lazy = true },
    },
    keys = {
      {
        '<leader>er',
        function()
          require('neo-tree.command').execute { toggle = true, dir = '/' }
        end,
        desc = '[E]xplorer [R]oot',
      },
      {
        '<leader>ef',
        function()
          require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
        end,
        desc = '[E]xplorer [F]ile',
      },
      {
        '<leader>eg',
        function()
          require('neo-tree.command').execute { source = 'git_status', toggle = true }
        end,
        desc = '[E]xplorer [G]it',
      },
      {
        '<leader>eb',
        function()
          require('neo-tree.command').execute { source = 'buffers', toggle = true }
        end,
        desc = '[E]xplorer [B]uffer',
      },
    },
    config = function()
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
      require('neo-tree').setup {
        auto_clean_after_session_restore = true,
        close_if_last_window = false,
        enable_diagnostics = true,
        enable_git_status = true,
        enable_modified_markers = true,
        enable_refresh_on_write = true,
        popup_border_style = 'rounded',
        sort_case_insensitive = true,
        sort_function = nil,
        use_popups_for_input = true,

        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            with_expanders = nil,
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          hijack_netrw_behavior = 'open_default',
          use_libuv_file_watcher = false,
          scan_mode = 'shallow',
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
              '.DS_Store',
              'thumbs.db',
              'node_modules',
              '.git',
              '.svn',
              '__pycache__',
              '.pytest_cache',
              '.mypy_cache',
              '.ruff_cache',
              '*.pyc',
              '*.pyo',
              '*.pyd',
              '.Python',
              'env',
              'venv',
              '.env',
              '.venv',
              'ENV',
              'env.bak',
              'venv.bak',
            },
            hide_by_pattern = {
              '*/src/*/tsconfig.json',
              '*.tmp',
              '*.temp',
            },
            always_show = {
              '.gitignored',
              '.gitattributes',
              '.github',
              '.ci',
            },
            never_show = {
              '.DS_Store',
              'thumbs.db',
            },
            never_show_by_pattern = {
              '.null-ls_*',
              '*.tmp',
              '.#*',
            },
          },

          bind_to_cwd = true,
          cwd_target = {
            sidebar = 'tab',
            current = 'window',
          },
        },

        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
        },
        window = {
          position = 'left',
          width = '15%',
          auto_expand_width = false,
        },
      }
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
        modes = {
            enabled = true,
        },
        char = {
            jump_labels = true,
        }
    },
    keys = {
      { "gl", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: Go Leap" },
      { "gL", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: Go Leap Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'chrisgrieser/nvim-spider',
    keys = {
      { 'w', '<cmd>lua require("spider").motion("w")<CR>', mode = { 'n', 'o', 'x' }, desc = 'Spider-w' },
      { 'e', '<cmd>lua require("spider").motion("e")<CR>', mode = { 'n', 'o', 'x' }, desc = 'Spider-e' },
      { 'b', '<cmd>lua require("spider").motion("b")<CR>', mode = { 'n', 'o', 'x' }, desc = 'Spider-b' },
      { 'ge', '<cmd>lua require("spider").motion("ge")<CR>', mode = { 'n', 'o', 'x' }, desc = 'Spider-ge' },
    },
    opts = {
      skipInsignificantPunctuation = true,
    },
  },
}
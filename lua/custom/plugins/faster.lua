return {
  {
    'pteroctopus/faster.nvim',
    event = 'VeryLazy',
    opts = {
      -- Behaviour configuration
      behaviours = {
        -- Bigfile configuration - disables features for large files
        bigfile = {
          on = true,
          features_disabled = {
            "illuminate", "matchparen", "lsp", "treesitter",
            "indent_blankline", "vimopts", "syntax", "filetype"
          },
          filesize = 7, -- in MB
          pattern = "*",
          extra_patterns = {
            { filesize = 5, pattern = "*.log" },   -- Log files over 5MB
            { filesize = 5, pattern = "*.md" },    -- Markdown files over 5MB
            { filesize = 5, pattern = "*.json" },  -- JSON files over 5MB
          },
        },
        -- Fast macro configuration - disables features during macro execution
        fastmacro = {
          on = true,
          features_disabled = { "lualine", "mini_clue" },
        }
      },
      -- Feature configuration
      features = {
        filetype = {
          on = true,
          defer = true,
        },
        illuminate = {
          on = true,
          defer = false,
        },
        indent_blankline = {
          on = true,
          defer = false,
        },
        lsp = {
          on = true,
          defer = false,
        },
        lualine = {
          on = true,
          defer = false,
        },
        matchparen = {
          on = true,
          defer = false,
        },
        syntax = {
          on = true,
          defer = true,
        },
        treesitter = {
          on = true,
          defer = false,
        },
        vimopts = {
          on = true,
          defer = false,
        },
        mini_clue = {
          on = true,
          defer = false,
        }
      }
    },
    config = function(_, opts)
      require('faster').setup(opts)
    end,
  }
}

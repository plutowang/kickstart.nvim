-- Adjust global defaults for floating windows
local orig_open_win = vim.api.nvim_open_win
vim.api.nvim_open_win = function(buffer, enter, config)
  -- Apply rounded border to all floating windows if not specified
  if config and config.relative and not config.border then
    config.border = 'rounded'
  end
  return orig_open_win(buffer, enter, config)
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.background = 'light'
      -- Disable recording messages at bottom
      vim.opt.shortmess:append 'q'

      require('catppuccin').setup {
        flavour = 'latte', -- Force latte for consistent light theme
        background = { -- :h background
          light = 'latte',
          dark = 'latte', -- Keep latte even for dark mode for consistency
        },
        transparent_background = false, -- Disable transparency for better readability
        show_end_of_buffer = false, -- Hide ~ chars for cleaner look
        term_colors = true, -- Enable terminal colors for better integration
        dim_inactive = {
          enabled = true, -- Enable dimming for better focus
          shade = 'light', -- Use light shade for light theme
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          loops = {},
          functions = { 'bold' },
          keywords = { 'bold' },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { 'italic' },
          operators = {},
        },
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = false, -- We use neo-tree instead
          neo_tree = true,
          treesitter = true,
          treesitter_context = true,
          notify = true, -- Enable notify integration
          mini = {
            enabled = true,
            indentscope_color = 'lavender', -- Use lavender for indent guides
          },
          barbar = true,
          mason = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
          which_key = true,
          flash = true,
          lsp_trouble = true,
          illuminate = { enabled = true, lsp = false },
          indent_blankline = {
            enabled = true,
            scope_color = 'lavender',
            colored_indent_levels = false,
          },
          -- Add more integrations for better consistency
          dap = { enabled = true, enable_ui = true },
          headlines = true,
          leap = true,
          markdown = true,
          neotest = true,
          noice = true,
          semantic_tokens = true,
        },
        custom_highlights = function(colors)
          return {
            -- Enhanced contrast for better readability
            CursorLine = { bg = colors.surface0 },
            CursorColumn = { bg = colors.surface0 },
            ColorColumn = { bg = colors.surface0 },
            -- Better visual separation
            WinSeparator = { fg = colors.overlay0, bg = colors.base },
            -- Enhanced search highlighting
            Search = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },
            IncSearch = { bg = colors.peach, fg = colors.base, style = { 'bold' } },
            -- Better fold appearance
            Folded = { bg = colors.surface1, fg = colors.overlay1, style = { 'italic' } },
            -- Enhanced selection
            Visual = { bg = colors.surface2 },
            -- Better line numbers
            LineNr = { fg = colors.overlay0 },
            CursorLineNr = { fg = colors.mauve, style = { 'bold' } },
            -- Improved popup menu
            Pmenu = { bg = colors.surface0, fg = colors.text },
            PmenuSel = { bg = colors.surface1, fg = colors.text, style = { 'bold' } },
            PmenuSbar = { bg = colors.surface1 },
            PmenuThumb = { bg = colors.overlay0 },
            -- Better floating windows
            NormalFloat = { bg = colors.mantle, fg = colors.text },
            FloatBorder = { bg = colors.mantle, fg = colors.blue },
            -- Enhanced diagnostics
            DiagnosticError = { fg = colors.red },
            DiagnosticWarn = { fg = colors.yellow },
            DiagnosticInfo = { fg = colors.sky },
            DiagnosticHint = { fg = colors.teal },
            -- Better git signs
            GitSignsAdd = { fg = colors.green },
            GitSignsChange = { fg = colors.yellow },
            GitSignsDelete = { fg = colors.red },
            -- Enhanced indent guides
            IblIndent = { fg = colors.surface1 },
            IblScope = { fg = colors.lavender },

            -- Elegant Blink.cmp styling
            -- Main completion menu
            CmpMenu = { bg = colors.mantle, fg = colors.text },
            CmpMenuBorder = { bg = colors.mantle, fg = colors.blue },
            CmpMenuSel = { bg = colors.surface0, fg = colors.text, style = { 'bold' } },

            -- Documentation window
            CmpDocumentation = { bg = colors.mantle, fg = colors.text },
            CmpDocumentationBorder = { bg = colors.mantle, fg = colors.lavender },
            CmpDocumentationCursorLine = { bg = colors.surface0 },

            -- Signature help
            CmpSignatureHelp = { bg = colors.mantle, fg = colors.text },
            CmpSignatureHelpBorder = { bg = colors.mantle, fg = colors.teal },

            -- Completion item highlights
            CmpItemAbbr = { fg = colors.text },
            CmpItemAbbrMatch = { fg = colors.blue, style = { 'bold' } },
            CmpItemAbbrMatchFuzzy = { fg = colors.sky, style = { 'bold' } },
            CmpItemMenu = { fg = colors.overlay1, style = { 'italic' } },

            -- Kind-specific highlights with colors
            CmpItemKindText = { fg = colors.green },
            CmpItemKindMethod = { fg = colors.blue },
            CmpItemKindFunction = { fg = colors.blue },
            CmpItemKindConstructor = { fg = colors.yellow },
            CmpItemKindField = { fg = colors.teal },
            CmpItemKindVariable = { fg = colors.mauve },
            CmpItemKindClass = { fg = colors.yellow },
            CmpItemKindInterface = { fg = colors.yellow },
            CmpItemKindModule = { fg = colors.blue },
            CmpItemKindProperty = { fg = colors.teal },
            CmpItemKindUnit = { fg = colors.green },
            CmpItemKindValue = { fg = colors.peach },
            CmpItemKindEnum = { fg = colors.yellow },
            CmpItemKindKeyword = { fg = colors.red },
            CmpItemKindSnippet = { fg = colors.mauve },
            CmpItemKindColor = { fg = colors.pink },
            CmpItemKindFile = { fg = colors.blue },
            CmpItemKindReference = { fg = colors.overlay2 },
            CmpItemKindFolder = { fg = colors.blue },
            CmpItemKindEnumMember = { fg = colors.teal },
            CmpItemKindConstant = { fg = colors.peach },
            CmpItemKindStruct = { fg = colors.yellow },
            CmpItemKindEvent = { fg = colors.red },
            CmpItemKindOperator = { fg = colors.sky },
            CmpItemKindTypeParameter = { fg = colors.maroon },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'catppuccin/nvim' },
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        extensions = { 'lazy', 'mason', 'neo-tree', 'nvim-dap-ui', 'toggleterm', 'trouble' },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = {
              error = '󰅚 ',
              warn = '󰀪 ',
              info = '󰋽 ',
              hint = '󰌶 ',
            },
            diagnostics_color = {
              error = { fg = '#e78284' }, -- red from catppuccin latte
              warn = { fg = '#e5c890' }, -- yellow from catppuccin latte
              info = { fg = '#99d1db' }, -- sky from catppuccin latte
              hint = { fg = '#81c8be' }, -- teal from catppuccin latte
            },
            always_visible = false,
            update_in_insert = false,
          },
          {
            function()
              local recording_register = vim.fn.reg_recording()
              if recording_register == '' then
                return ''
              else
                return '󰑋 ' .. recording_register
              end
            end,
            color = { fg = '#eff1f5', bg = '#e78284', style = 'bold' }, -- white text on red background
            separator = { left = '', right = '' }, -- rounded separators
            padding = { left = 1, right = 1 },
          },
        },
        lualine_x = {
          {
            'diff',
            symbols = {
              added = '󰐕 ',
              modified = '󰏫 ',
              removed = '󰍴 ',
            },
            diff_color = {
              added = { fg = '#a6d189' }, -- green from catppuccin latte
              modified = { fg = '#e5c890' }, -- yellow from catppuccin latte
              removed = { fg = '#e78284' }, -- red from catppuccin latte
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = { 'encoding', 'fileformat', 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
}

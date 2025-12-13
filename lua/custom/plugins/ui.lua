-- UI enhancements
vim.opt.pumblend = 15
vim.opt.winblend = 15
vim.opt.smoothscroll = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Add rounded borders to all floating windows
local orig_open_win = vim.api.nvim_open_win
vim.api.nvim_open_win = function(buffer, enter, config)
  if config and config.relative then
    config.border = config.border or 'rounded'
    if not config.style then
      config.style = 'minimal'
    end
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
      vim.opt.shortmess:append 'q'

      require('catppuccin').setup {
        flavour = 'latte',
        background = {
          light = 'latte',
          dark = 'latte',
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = 'light',
          percentage = 0.12,
        },
        color_overrides = {
          latte = {
            base = '#faf8f5',
            mantle = '#f2f0ed',
            surface0 = '#ede9e6',
          },
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
          nvimtree = false,
          neo_tree = true,
          treesitter = true,
          treesitter_context = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = 'lavender',
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
          dap = { enabled = true, enable_ui = true },
          headlines = true,
          leap = true,
          markdown = true,
          neotest = true,
          noice = true,
          semantic_tokens = true,
          alpha = true,
          dashboard = true,
          dropbar = true,
          fidget = true,
          harpoon = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          snacks = true,
          render_markdown = true,
          avante = true,
        },
        custom_highlights = function(colors)
          return {
            -- Editor UI
            CursorLine = { bg = colors.surface0 },
            CursorColumn = { bg = colors.surface0 },
            ColorColumn = { bg = colors.surface0 },
            WinSeparator = { fg = colors.overlay0, bg = colors.base },
            Folded = { bg = colors.surface1, fg = colors.overlay1, style = { 'italic' } },
            Visual = { bg = colors.surface2 },

            -- Line numbers
            LineNr = { fg = colors.overlay0 },
            CursorLineNr = { fg = colors.mauve, style = { 'bold' } },

            -- Search
            Search = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },
            IncSearch = { bg = colors.peach, fg = colors.base, style = { 'bold' } },

            -- Popup menu
            Pmenu = { bg = colors.surface0, fg = colors.text },
            PmenuSel = { bg = colors.surface1, fg = colors.text, style = { 'bold' } },
            PmenuSbar = { bg = colors.surface1 },
            PmenuThumb = { bg = colors.overlay0 },

            -- Floating windows
            NormalFloat = { bg = colors.mantle, fg = colors.text },
            FloatBorder = { bg = colors.mantle, fg = colors.lavender },
            FloatTitle = { bg = colors.mantle, fg = colors.blue, style = { 'bold' } },
            FloatFooter = { bg = colors.mantle, fg = colors.overlay1, style = { 'italic' } },

            -- Diagnostics
            DiagnosticError = { fg = colors.red },
            DiagnosticWarn = { fg = colors.yellow },
            DiagnosticInfo = { fg = colors.sky },
            DiagnosticHint = { fg = colors.teal },

            -- Git signs
            GitSignsAdd = { fg = colors.green },
            GitSignsChange = { fg = colors.yellow },
            GitSignsDelete = { fg = colors.red },

            -- Indent guides
            IblIndent = { fg = colors.surface1 },
            IblScope = { fg = colors.lavender },

            -- Completion menu (blink.cmp)
            CmpMenu = { bg = colors.mantle, fg = colors.text },
            CmpMenuBorder = { bg = colors.mantle, fg = colors.blue },
            CmpMenuSel = { bg = colors.surface0, fg = colors.text, style = { 'bold' } },
            CmpDocumentation = { bg = colors.mantle, fg = colors.text },
            CmpDocumentationBorder = { bg = colors.mantle, fg = colors.lavender },
            CmpDocumentationCursorLine = { bg = colors.surface0 },
            CmpSignatureHelp = { bg = colors.mantle, fg = colors.text },
            CmpSignatureHelpBorder = { bg = colors.mantle, fg = colors.teal },
            CmpItemAbbr = { fg = colors.text },
            CmpItemAbbrMatch = { fg = colors.blue, style = { 'bold' } },
            CmpItemAbbrMatchFuzzy = { fg = colors.sky, style = { 'bold' } },
            CmpItemMenu = { fg = colors.overlay1, style = { 'italic' } },

            -- Completion kinds
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

            -- LSP references
            LspReferenceText = { bg = colors.surface1, style = { 'bold' } },
            LspReferenceRead = { bg = colors.surface1, style = { 'bold' } },
            LspReferenceWrite = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },

            -- Illuminate (word highlighting)
            IlluminatedWordText = { bg = colors.surface2, style = { 'bold' } },
            IlluminatedWordRead = { bg = colors.surface2, style = { 'bold' } },
            IlluminatedWordWrite = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },

            -- Telescope
            TelescopeNormal = { bg = colors.mantle, fg = colors.text },
            TelescopeBorder = { bg = colors.mantle, fg = colors.lavender },
            TelescopeTitle = { bg = colors.lavender, fg = colors.mantle, style = { 'bold' } },
            TelescopeSelection = { bg = colors.surface0, fg = colors.text, style = { 'bold' } },
            TelescopeSelectionCaret = { fg = colors.flamingo },
            TelescopeMatching = { fg = colors.blue, style = { 'bold' } },
            TelescopePromptPrefix = { fg = colors.flamingo },
            TelescopePromptCounter = { fg = colors.overlay1 },

            -- Notifications
            NotifyBackground = { bg = colors.base },
            NotifyERRORBorder = { fg = colors.red },
            NotifyWARNBorder = { fg = colors.yellow },
            NotifyINFOBorder = { fg = colors.sky },
            NotifyDEBUGBorder = { fg = colors.overlay0 },
            NotifyTRACEBorder = { fg = colors.pink },
            NotifyERRORTitle = { fg = colors.red, style = { 'bold' } },
            NotifyWARNTitle = { fg = colors.yellow, style = { 'bold' } },
            NotifyINFOTitle = { fg = colors.sky, style = { 'bold' } },
            NotifyDEBUGTitle = { fg = colors.overlay0, style = { 'bold' } },
            NotifyTRACETitle = { fg = colors.pink, style = { 'bold' } },

            -- Which-key
            WhichKey = { fg = colors.lavender, style = { 'bold' } },
            WhichKeyGroup = { fg = colors.blue },
            WhichKeyDesc = { fg = colors.text },
            WhichKeySeparator = { fg = colors.overlay1 },
            WhichKeyFloat = { bg = colors.mantle },
            WhichKeyBorder = { bg = colors.mantle, fg = colors.lavender },

            -- Neo-tree
            NeoTreeNormal = { bg = colors.mantle, fg = colors.text },
            NeoTreeNormalNC = { bg = colors.mantle, fg = colors.text },
            NeoTreeWinSeparator = { bg = colors.base, fg = colors.base },
            NeoTreeFloatBorder = { bg = colors.mantle, fg = colors.lavender },
            NeoTreeFloatTitle = { bg = colors.mantle, fg = colors.lavender, style = { 'bold' } },

            -- Mason
            MasonNormal = { bg = colors.mantle, fg = colors.text },
            MasonHeader = { bg = colors.blue, fg = colors.mantle, style = { 'bold' } },
            MasonHeaderSecondary = { bg = colors.lavender, fg = colors.mantle, style = { 'bold' } },
            MasonHighlight = { fg = colors.blue },
            MasonHighlightBlock = { bg = colors.blue, fg = colors.mantle },
            MasonHighlightBlockBold = { bg = colors.blue, fg = colors.mantle, style = { 'bold' } },
            MasonHighlightSecondary = { fg = colors.lavender },
            MasonHighlightBlockSecondary = { bg = colors.lavender, fg = colors.mantle },
            MasonHighlightBlockBoldSecondary = { bg = colors.lavender, fg = colors.mantle, style = { 'bold' } },
            MasonMuted = { fg = colors.overlay1 },
            MasonMutedBlock = { bg = colors.overlay1, fg = colors.mantle },
            MasonMutedBlockBold = { bg = colors.overlay1, fg = colors.mantle, style = { 'bold' } },

            -- Angular variable highlighting
            ['@variable.angular'] = { fg = colors.mauve, style = { 'italic' } },

            -- Avante UI
            AvanteTitle = { bg = colors.lavender, fg = colors.base, style = { 'bold' } },
            AvanteReversedTitle = { fg = colors.lavender, style = { 'bold' } },
            AvanteSubtitle = { bg = colors.peach, fg = colors.base, style = { 'bold' } },
            AvanteReversedSubtitle = { fg = colors.peach, style = { 'bold' } },
            AvanteThirdTitle = { bg = colors.blue, fg = colors.base, style = { 'bold' } },
            AvanteReversedThirdTitle = { fg = colors.blue, style = { 'bold' } },
            AvanteInlineHint = { fg = colors.overlay2, style = { 'italic' } },
            AvantePopupHint = { fg = colors.overlay2, style = { 'italic' } },
            AvanteAnnotation = { fg = colors.overlay2, style = { 'italic' } },
            AvanteSuggestion = { fg = colors.overlay1, style = { 'italic' } },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'catppuccin/nvim' },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        extensions = { 'lazy', 'mason', 'neo-tree', 'nvim-dap-ui', 'trouble', 'fzf' },
        globalstatus = true,
        disabled_filetypes = {
          statusline = { 'alpha', 'dashboard' },
          winbar = { 'alpha', 'dashboard', 'neo-tree' },
        },
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = {
          {
            'filename',
            path = 1,
            symbols = { modified = '●', readonly = '', unnamed = '[No Name]' },
          },
          { 'branch', icon = '', color = { gui = 'bold' } },
        },
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
              error = { fg = '#e78284' },
              warn = { fg = '#e5c890' },
              info = { fg = '#99d1db' },
              hint = { fg = '#81c8be' },
            },
            always_visible = false,
            update_in_insert = false,
          },
          {
            -- Recording indicator
            function()
              local recording_register = vim.fn.reg_recording()
              if recording_register == '' then
                return ''
              else
                return '󰑋 ' .. recording_register
              end
            end,
            color = { fg = '#eff1f5', bg = '#e78284', gui = 'bold' },
            separator = { left = '', right = '' },
            padding = { left = 1, right = 1 },
          },
          {
            -- Active LSP clients
            function()
              local clients = vim.lsp.get_clients { bufnr = 0 }
              if #clients == 0 then
                return ''
              end
              local client_names = {}
              for _, client in ipairs(clients) do
                table.insert(client_names, client.name)
              end
              return '󰒋 ' .. table.concat(client_names, ', ')
            end,
            color = { fg = '#8839ef' },
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
              added = { fg = '#a6d189' },
              modified = { fg = '#e5c890' },
              removed = { fg = '#e78284' },
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
          {
            -- Avante mode indicator
            function()
              if package.loaded['avante'] == nil then
                return ''
              end
              
              local ok, avante_config = pcall(require, 'avante.config')
              if not ok or not avante_config then
                return ''
              end
              
              local mode = avante_config.mode or 'legacy'
              if mode == 'agentic' then
                return '󱙺 Agent'
              else
                return '󰭹 Chat'
              end
            end,
            color = function()
              if package.loaded['avante'] == nil then
                return { fg = '#7c7f93' }
              end
              
              local ok, avante_config = pcall(require, 'avante.config')
              if not ok or not avante_config then
                return { fg = '#7c7f93' }
              end
              
              local mode = avante_config.mode or 'legacy'
              if mode == 'agentic' then
                return { fg = '#eff1f5', bg = '#8839ef', gui = 'bold' }
              else
                return { fg = '#eff1f5', bg = '#1e66f5', gui = 'bold' }
              end
            end,
            separator = { left = '', right = '' },
            padding = { left = 1, right = 1 },
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


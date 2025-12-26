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

local themes = {
  latte = { flavour = 'latte', background = 'light' },
  nge = { 
    flavour = 'mocha', 
    background = 'dark',
    color_overrides = {
      mocha = {
        base = '#1a1a2e',      -- Deep purple-tinted dark
        mantle = '#16213e',    -- Darker purple-blue
        surface0 = '#2a2d3a',  -- Medium surface
        
        -- Eva Unit-01 main colors
        lavender = '#9966cc',  -- Eva Unit-01 purple (main)
        green = '#90ee90',     -- Eva Unit-01 green (main)
        mauve = '#c574dd',     -- Light purple accent
        peach = '#ff6b35',     -- Eva Unit-02 orange
      }
    }
  },
}

-- Get current theme (default to latte)
local function get_active_theme_name()
  return vim.g.current_color_theme or 'latte'
end

-- Set current theme
local function set_active_theme(theme_name)
  vim.g.current_color_theme = theme_name
  -- Save to session for persistence
  vim.schedule(function()
    if vim.v.this_session ~= '' then
      vim.cmd('mksession!')
    end
  end)
end

-- Simple theme color manager
local theme_colors = {
  get_active_theme = function()
    return get_active_theme_name()
  end,
  
  get_theme_based_value = function(nge_value, latte_value)
    return get_active_theme_name() == 'nge' and nge_value or latte_value
  end,
  
  get_badge_colors = function(component)
    local is_nge = get_active_theme_name() == 'nge'
    -- NGE uses Eva Unit-01 purple and green as main colors
    if component == 'theme' then
      return is_nge and { fg = '#1a1a2e', bg = '#9966cc', gui = 'bold' } -- Eva purple
                    or { fg = '#4c4f69', bg = '#f5c2e7', gui = 'bold' }
    else
      return is_nge and { fg = '#1a1a2e', bg = '#90ee90', gui = 'bold' } -- Eva green
                    or { fg = '#eff1f5', bg = '#8839ef', gui = 'bold' }
    end
  end,
}

-- Toggle between themes
local function toggle_between_themes()
  local current = get_active_theme_name()
  local new_theme = current == 'latte' and 'nge' or 'latte'
  set_active_theme(new_theme)
  
  -- Reload and reconfigure the entire theme
  require('plenary.reload').reload_module('custom.plugins.ui.theme')
  
  -- Reconfigure catppuccin with new theme
  local theme_config = themes[new_theme]
  vim.opt.background = theme_config.background
  
  require('catppuccin').setup {
    flavour = theme_config.flavour,
    color_overrides = theme_config.color_overrides or {},
  }
  
  vim.cmd('colorscheme catppuccin')
  
  -- Refresh lualine
  if package.loaded['lualine'] then
    require('lualine').refresh()
  end
end

-- Expose toggle function globally
_G.toggle_color_theme = toggle_between_themes

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    event = 'VeryLazy',
    init = function()
      -- set colorscheme immediately in init
      -- make up for lazy loading delay
      vim.cmd.colorscheme 'catppuccin'
    end,
    config = function()
      local current_theme = get_active_theme_name()
      local theme_config = themes[current_theme]
      
      vim.opt.background = theme_config.background
      vim.opt.shortmess:append 'q'

      require('catppuccin').setup {
        flavour = theme_config.flavour,
        background = {
          light = theme_config.flavour,
          dark = theme_config.flavour,
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = current_theme == 'latte' and 'light' or 'dark',
          percentage = 0.12,
        },
        color_overrides = theme_config.color_overrides,
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
        default_integrations = false,
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
          blink_cmp = true,
        },
        custom_highlights = function(colors)
          -- https://github.com/catppuccin/nvim/tree/main/lua/catppuccin/groups
          return {
            -- Editor UI
            CursorLine = { bg = colors.surface0 },
            CursorColumn = { bg = colors.surface0 },
            ColorColumn = { bg = colors.surface0 },
            WinSeparator = { fg = colors.overlay0, bg = colors.base },
            Folded = { style = { 'italic', 'bold' } },

            -- Line numbers
            LineNr = { fg = colors.overlay0 },
            CursorLineNr = { fg = colors.mauve, style = { 'bold' } },

            -- Floating windows
            NormalFloat = { bg = colors.mantle, fg = colors.text },
            FloatBorder = { bg = colors.mantle, fg = colors.lavender },
            FloatTitle = { bg = colors.mantle, fg = colors.blue, style = { 'bold' } },
            FloatFooter = { bg = colors.mantle, fg = colors.overlay1, style = { 'italic' } },

            -- Diagnostics
            DiagnosticHint = { fg = colors.teal },

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

            -- LSP references
            LspReferenceText = { bg = colors.surface1, style = { 'bold' } },
            LspReferenceRead = { bg = colors.surface1, style = { 'bold' } },
            LspReferenceWrite = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },

            -- Telescope
            TelescopeNormal = { bg = colors.mantle, fg = colors.text },
            TelescopeBorder = { bg = colors.mantle, fg = colors.lavender },
            TelescopeTitle = { bg = colors.lavender, fg = colors.mantle, style = { 'bold' } },
            TelescopeSelection = { bg = colors.surface0, fg = colors.text, style = { 'bold' } },
            TelescopeSelectionCaret = { fg = colors.flamingo },
            TelescopeMatching = { fg = colors.blue, style = { 'bold' } },
            TelescopePromptPrefix = { fg = colors.flamingo },
            TelescopePromptCounter = { fg = colors.overlay1 },

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

            -- Neotest UI
            NeotestPassed = { fg = colors.green, style = { 'bold' } },
            NeotestFailed = { fg = colors.red, style = { 'bold' } },
            NeotestRunning = { fg = colors.yellow, style = { 'bold' } },
            NeotestSkipped = { fg = colors.blue, style = { 'bold' } },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 
      'catppuccin/nvim', 
      { 'nvim-lua/plenary.nvim', lazy = true },
      { 'nvim-tree/nvim-web-devicons', lazy = true, module = "nvim-web-devicons",  }
    },
    config = function()
      local separators = {
        left = '',
        right = '',
        left_thin = '',
        right_thin = '',
      }
      
      local function get_theme_colors()
        local colors = require('catppuccin.palettes').get_palette()
        return colors
      end
      
      -- Custom diff colors for better visual appeal
      local function get_diff_colors()
        local colors = get_theme_colors()
        return {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red },
        }
      end
      
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'catppuccin',
          component_separators = { left = separators.left_thin, right = separators.right_thin },
          section_separators = { left = separators.left, right = separators.right },
          extensions = { 'lazy', 'mason', 'neo-tree', 'nvim-dap-ui', 'trouble', 'fzf' },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { 'alpha', 'dashboard' },
            winbar = { 'alpha', 'dashboard', 'neo-tree' },
          },
          refresh = {
            statusline = 2000,
            tabline = 3000,
            winbar = 3000,
          },
        },
        sections = {
          lualine_a = { 
            {
              'mode',
              separator = { left = '', right = separators.right },
            }
          },
          lualine_b = {
            {
                'filename',
                path = 1,
                symbols = {
                  modified = '󰏫 ',
                  readonly = '󰌾 ',
                  unnamed = '󰈔 ',
                  newfile = '󰎔 ',
                },
                color = { gui = 'bold' },
                separator = { right = separators.right_thin },
                padding = { left = 1, right = 1 },
                fmt = function(str)
                    local max_length = 40
                    if #str > max_length then
                        local separator = package.config:sub(1,1)
                        local parts = {}
                        for part in string.gmatch(str, "[^" .. separator .. "]+") do
                            table.insert(parts, part)
                        end
                        if #parts >= 2 then
                            return "…/" .. parts[#parts - 1] .. "/" .. parts[#parts]
                        else
                            return str
                        end
                    end
                    return str
                end
            },
            {
                'branch',
                icon = '󰊢',
                color = { gui = 'italic' },
                separator = { right = separators.right_thin },
                padding = { left = 1, right = 1 },
                fmt = function(str)
                    if #str > 20 then
                        return str:sub(1, 17) .. '…'
                    end
                    return str
                end
            }
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
                info = { fg = '#81c8be' },
                hint = { fg = '#a6d189' },
              },
              always_visible = false,
              update_in_insert = false,
              padding = { left = 1, right = 1 },
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
              color = function()
                local colors = get_theme_colors()
                return { fg = colors.base, bg = colors.red, gui = 'bold' }
              end,
              separator = { left = separators.left, right = separators.right },
              padding = { left = 1, right = 1 },
            },
            {
              function()
                local clients = vim.lsp.get_clients { bufnr = 0 }
                if #clients == 0 then
                  return ''
                end
                local client_names = {}
                for _, client in ipairs(clients) do
                  table.insert(client_names, client.name)
                end
                return '󰒋 ' .. table.concat(client_names, '∙')
              end,
              color = function()
                local colors = get_theme_colors()
                return { fg = colors.lavender, gui = 'italic' }
              end,
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
              diff_color = get_diff_colors(),
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
              padding = { left = 1, right = 1 },
            },
            {
              function()
                if get_active_theme_name() == 'nge' then
                  return '󱎴 Eva Unit-01'
                else
                  return ''
                end
              end,
              color = function() 
                return theme_colors.get_badge_colors('theme') 
              end,
              separator = { left = separators.left, right = separators.right },
              padding = { left = 1, right = 1 },
            },
            {
              function()
                if vim.g.experimental_enabled then
                  return '󰙨 Lab'
                else
                  return ''
                end
              end,
              color = function() 
                local colors = get_theme_colors()
                return { fg = colors.base, bg = colors.peach, gui = 'bold' }
              end,
              separator = { left = separators.left, right = separators.right },
              padding = { left = 1, right = 1 },
            },
            {
              function()
                if package.loaded['avante'] == nil then
                  return ''
                end
                
                local avante_config = require('avante.config')
                local mode = avante_config.mode or 'legacy'
                if mode == 'agentic' then
                  return '󱙺 Agent'
                else
                  return '󰭹 Chat'
                end
              end,
              color = function()
                if package.loaded['avante'] == nil then
                  return {}
                end
                local colors = get_theme_colors()
                local avante_config = require('avante.config')
                local mode = avante_config.mode or 'legacy'
                if mode == 'agentic' then
                  return { fg = colors.base, bg = colors.green, gui = 'bold' }
                else
                  return { fg = colors.base, bg = colors.blue, gui = 'bold' }
                end
              end,
              separator = { left = separators.left, right = separators.right },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_y = { 
            {
              'encoding',
              color = { gui = 'italic' },
            },
            {
              'fileformat',
              symbols = {
                unix = '󰻀',
                dos = '󰍲',
                mac = '󰀵',
              },
            },
            {
              'filetype',
              icon_only = false,
              colored = true,
            },
            {
              'progress',
              color = { gui = 'bold' },
              separator = { left = separators.left_thin },
              padding = { left = 1, right = 1 },
            }
          },
          lualine_z = { 
            {
              'location',
              separator = { left = separators.left, right = '' },
            }
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 
            {
              'filename',
              color = { gui = 'italic' },
              symbols = {
                modified = '󰏫 ',
                readonly = '󰌾 ',
              },
            }
          },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
      }
    end,
  },
}


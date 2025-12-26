return {
  {
    'saghen/blink.cmp',
    lazy = true,
    event = { 'InsertEnter' },
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        lazy = true,
        event = { 'InsertEnter' },
        cmd = { 'LuaSnipEdit' },
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = {
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
          Text = '󰉿',
          Method = '󰆧',
          Function = '󰊕',
          Constructor = '',
          Field = '󰜢',
          Variable = '󰀫',
          Class = '󰠱',
          Interface = '',
          Module = '',
          Property = '󰜢',
          Unit = '󰑭',
          Value = '󰎠',
          Enum = '',
          Keyword = '󰌋',
          Snippet = '',
          Color = '󰏘',
          File = '󰈙',
          Reference = '󰈇',
          Folder = '󰉋',
          EnumMember = '',
          Constant = '󰏿',
          Struct = '󰙅',
          Event = '',
          Operator = '󰆕',
          TypeParameter = '',
        },
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = 'rounded',
            winhighlight = 'Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:CmpDocumentationCursorLine,Search:None',
            scrollbar = true,
            max_width = 80,
            max_height = 20,
          },
        },
        menu = {
          border = 'rounded',
          winhighlight = 'Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpMenuSel,Search:None',
          max_height = 15,
          draw = {
            treesitter = { 'lsp' },
            columns = {
              { 'kind_icon', 'label', gap = 1 },
              { 'label_description', gap = 1 },
              { 'source_name' },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon = ctx.kind_icon
                  return kind_icon .. ' '
                end,
                highlight = function(ctx)
                  return 'CmpItemKind' .. ctx.kind
                end,
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  return ctx.label .. ctx.label_detail
                end,
                highlight = function(ctx)
                  -- Label highlight by source
                  local highlights = {
                    nvim_lsp = 'CmpItemAbbrMatch',
                    buffer = 'CmpItemAbbrMatchFuzzy',
                    path = 'CmpItemAbbrMatchFuzzy',
                  }
                  return highlights[ctx.source_name] or 'CmpItemAbbr'
                end,
              },
              label_description = {
                width = { max = 30 },
                text = function(ctx)
                  return ctx.label_description
                end,
                highlight = 'CmpItemMenu',
              },
            },
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = {
        implementation = 'lua',
        sorts = { 'label', 'kind', 'score' },
      },

      -- Shows a signature help window while you type arguments for a function
      signature = {
        enabled = true,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:CmpSignatureHelp,FloatBorder:CmpSignatureHelpBorder',
          scrollbar = false,
        },
      },
    },
  },
}

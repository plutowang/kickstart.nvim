-- LSP enhancements and development tools
-- Improve LSP experience without impacting performance

return {
  -- Performant LSP progress indicator
  {
    'linrongbin16/lsp-progress.nvim',
    event = 'VeryLazy',
    config = function()
      require('lsp-progress').setup {
        debug = false,
        console_log = false,
        file_log = false,
        format = function(client_messages)
          if #client_messages == 0 then
            return ''
          end
          local builder = {}
          for _, client_message in ipairs(client_messages) do
            if client_message.message then
              table.insert(builder, '[' .. client_message.name .. '] ' .. client_message.message)
            end
          end
          if #builder > 0 then
            return '  ' .. table.concat(builder, ', ')
          end
          return ''
        end,
        max_size = 80, -- Max message length
      }
      
      -- Integration with lualine (if you have it)
      -- Add to your lualine sections:
      -- require('lsp-progress').progress
    end,
  },
}
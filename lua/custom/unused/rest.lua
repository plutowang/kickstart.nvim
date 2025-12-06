return {
  {
    'rest-nvim/rest.nvim',
    enabled = function()
      if vim.fn.has 'win32' == 1 then
        return false
      end
      return true
    end,
    ft = "http",
    dependencies = {
      'luarocks.nvim',
    },
    config = function()
      -- local map = vim.api.nvim_set_keymap
      -- local opts = { noremap = true, silent = true }
      -- map('n', '<leader>rt', '<Plug>RestNvim', opts)
      -- map('n', '<leader>rp', '<Plug>RestNvimPreview', opts)
      -- map('n', '<leader>rl', '<Plug>RestNvimLast', opts)

      require('rest-nvim').setup {
        client = 'curl',
        env_file = '.env',
        env_pattern = '\\.env$',
        env_edit_command = 'tabedit',
        encode_url = true,
        skip_ssl_verification = false,
        custom_dynamic_variables = {},
        logs = {
          level = 'info',
          save = true,
        },
        result = {
          split = {
            horizontal = false,
            in_place = false,
            stay_in_current_window_after_split = true,
          },
          behavior = {
            decode_url = true,
            show_info = {
              url = true,
              headers = true,
              http_info = true,
              curl_command = true,
            },
            statistics = {
              enable = true,
              ---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
              stats = {
                { 'total_time', title = 'Time taken:' },
                { 'size_download_t', title = 'Download size:' },
              },
            },
            formatters = {
              json = 'jq',
              html = function(body)
                if vim.fn.executable 'tidy' == 0 then
                  return body, { found = false, name = 'tidy' }
                end
                local fmt_body = vim.fn
                                    .system({
                  'tidy',
                  '-i',
                  '-q',
                  '--tidy-mark',
                  'no',
                  '--show-body-only',
                  'auto',
                  '--show-errors',
                  '0',
                  '--show-warnings',
                  '0',
                  '-',
                }, body)
                                    :gsub('\n$', '')

                return fmt_body, { found = true, name = 'tidy' }
              end,
            },
          },
        },
        highlight = {
          enable = true,
          timeout = 750,
        },
        ---@see vim.keymap.set
        keybinds = {
          {
            '<leader>rr',
            '<cmd>Rest run<cr>',
            '[R]un [r]equest under the cursor',
          },
          {
            '<leader>rl',
            '<cmd>Rest run last<cr>',
            '[R]e-run [l]atest request',
          },
          {
            '<leader>rs',
            '<cmd>Telescope rest select_env<cr>',
            '[R]est [S]elect Env File',
          },
        },
      }
    end,
  }
}

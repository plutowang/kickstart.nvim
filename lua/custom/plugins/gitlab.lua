return {
  {
    'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
    -- Activate when a file is created/opened
    event = { 'BufReadPre', 'BufNewFile' },
    -- Activate when a supported filetype is open
    ft = { 'go', 'javascript', 'python', 'ruby' },
    cond = function()
      -- Only activate if token is present in environment variable.
      -- Remove this line to use the interactive workflow.
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
    end,
    opts = {
      statusline = {
        -- Hook into the built-in statusline to indicate the status
        -- of the GitLab Duo Code Suggestions integration
        enabled = true,
      },
    },
    code_suggestions = {
      -- For the full list of default languages, see the 'auto_filetypes' array in
      -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
      auto_filetypes = { 'ruby', 'go' }, -- Default is { 'ruby' }
      ghost_text = {
        enabled = false, -- ghost text is an experimental feature
        toggle_enabled = '<C-g><C-e>',
        accept_suggestion = '<C-g><C-a>',
        clear_suggestions = '<C-g><C-c>',
        stream = true,
      },
    },
  },
}

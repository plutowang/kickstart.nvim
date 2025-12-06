return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
      })
    end,
  },
  {
    'yetone/avante.nvim',
    -- If there is issues, try:
    -- 1. Delete ~/.local/share/nvim/lazy/avante.nvim
    -- 2. Start nvim, :Lazy + sync
    -- 3. Build manually:
    --    - cd ~/.local/share/nvim/lazy/avante.nvim
    --    - make
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has('win32') == 1 then
        return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      else
        return 'make'
      end
    end,
    --event = 'VeryLazy',
    -- key bindings:
    -- https://github.com/yetone/avante.nvim?tab=readme-ov-file#key-bindings
    keys = {
      { '<leader>aa', desc = '[A]vante: [A]sk' },
      { '<leader>an', desc = '[A]vante: [N]ew ask' },
    },
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = function()
      -- Check if Copilot is authenticated
      local copilot_authenticated = vim.fn.filereadable(vim.fn.expand('~/.config/github-copilot/apps.json')) == 1
      
      -- Use copilot if authenticated, otherwise fallback to ollama
      local default_provider = copilot_authenticated and 'copilot' or 'ollama'
      -- Build providers list based on authentication status
      local providers = {
        ollama = {
          endpoint = 'http://localhost:11434',
          model = 'codellama:13b',
          timeout = 30000,
          is_env_set = require("avante.providers.ollama").check_endpoint_alive,
        },
      }

      -- Only add Copilot provider if authenticated
      if copilot_authenticated then
        providers.copilot = {
          endpoint = 'https://api.githubcopilot.com',
          model = 'claude-sonnet-4',
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        }
      end
      
      return {
        -- comment out to enable `agentic` mode
        -- mode = "legacy",

        -- Automatically use copilot if available, otherwise ollama
        provider = default_provider,
        auto_suggestions_provider = default_provider,
        providers = providers,
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'ibhagwan/fzf-lua',
      'stevearc/dressing.nvim',
      'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
      -- ⚠️ Note: run :Copilot auth once to authenticate Copilot
      'zbirenbaum/copilot.lua',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
    },
    -- alrady add in markdown.lua
    --{
    --  -- Make sure to set this up properly if you have lazy=true
    --  'MeanderingProgrammer/render-markdown.nvim',
    --  opts = {
    --    file_types = { 'markdown', 'Avante' },
    --  },
    --  ft = { 'markdown', 'Avante' },
    --},
  },
}
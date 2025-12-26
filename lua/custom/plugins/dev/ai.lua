return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = true },
        panel = { enabled = true },
      }
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
      if vim.fn.has 'win32' == 1 then
        return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      else
        return 'make'
      end
    end,
    -- key bindings:
    -- https://github.com/yetone/avante.nvim?tab=readme-ov-file#key-bindings
    keys = {
      { '<leader>aa', desc = '[A]vante: [A]sk' },
      { '<leader>an', desc = '[A]vante: [N]ew ask' },
      { '<leader>am', desc = '[A]vante: Toggle [M]ode (Chat/Agent)' },
    },
    version = false, -- Never set this value to "*"! Never!
    opts = function()
      -- Check if Copilot is authenticated
      local copilot_authenticated = vim.fn.filereadable(vim.fn.expand '~/.config/github-copilot/apps.json') == 1

      -- Use copilot if authenticated, otherwise fallback to ollama
      local default_provider = copilot_authenticated and 'copilot' or 'ollama'
      -- Build providers list based on authentication status
      local providers = {
        ollama = {
          endpoint = 'http://localhost:11434',
          model = 'codellama:13b',
          timeout = 30000,
          is_env_set = require('avante.providers.ollama').check_endpoint_alive,
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
        -- Mode configuration: "agentic" (default) or "legacy"
        -- "agentic": AI can automatically execute tools with permission control
        -- "legacy": Traditional mode requiring manual approval for all actions
        mode = "legacy",

        -- Provider configuration
        provider = default_provider,
        auto_suggestions_provider = default_provider,
        providers = providers,

        -- Behavior configuration for better control
        behaviour = {
          -- Permission control for AI tools (true, {"str_replace", "view"})
          auto_approve_tool_permissions = false, -- Show permission prompts for all tools
          -- Examples of fine-grained control:
          
          -- UI and workflow settings
          auto_apply_diff_after_generation = false,
          confirmation_ui_style = "inline_buttons",
          auto_add_current_file = true,
          minimize_diff = true,
          jump_result_buffer_on_finish = true,
          
          -- Advanced settings
          auto_focus_sidebar = true,
          enable_token_counting = true,
          auto_check_diagnostics = true,
        },
        highlights = {
          diff = {
            current = "DiffText",
            incoming = "DiffAdd",
          },
        },
        -- Enhanced key mappings for better workflow
        mappings = {
          sidebar = {
            apply_all = "A",           -- Apply all suggested changes
            apply_cursor = "a",        -- Apply change under cursor
            retry_user_request = "r",  -- Retry last request
            edit_user_request = "e",   -- Edit and resend request
            switch_windows = "<Tab>",  -- Switch between windows
            reverse_switch_windows = "<S-Tab>", -- Reverse window switch
            expand_tool_use = "<S-Tab>", -- Expand/collapse tool details
            remove_file = "d",         -- Remove file from context
            add_file = "@",           -- Add file to context
            close = { "<Esc>", "q" }, -- Close sidebar
          },
          jump = {
            next = "]]",              -- Jump to next code block
            prev = "[[",              -- Jump to previous code block
          },
          -- Custom mode toggle
          toggle = {
            mode = "<leader>am",      -- Toggle between chat and agent modes
          },
          -- Git-style approval shortcuts (custom)
          approval = {
             reject = "co",            -- Reject (like git "choose ours")  
             accept = "ct",            -- Accept (like git "choose theirs")
          },
        },
      }
    end,
    config = function(_, opts)
      require('avante').setup(opts)

      -- In light theme, visibility of the diff view is bad.
      -- https://github.com/yetone/avante.nvim/issues/2491
      vim.api.nvim_set_hl(0, "AvanteToBeDeletedWOStrikethrough", { link = "DiffDelete" })
      
      -- Custom mode toggle function
      local function toggle_mode()
        local Config = require('avante.config')
        local current_mode = Config.mode
        local new_mode = current_mode == "agentic" and "legacy" or "agentic"
        
        -- Override the configuration
        Config.override({ mode = new_mode })    
      end
      
      -- Set up the mode toggle keymap
      vim.keymap.set('n', '<leader>am', toggle_mode, {
        desc = 'Toggle Avante mode (Chat/Agent)',
        noremap = true,
        silent = true
      })
      
      -- Add git-style approval keymaps for Avante sidebar
      local function setup_approval_keymaps()
        local sidebar = require('avante').get()
        if sidebar and sidebar.containers.result then
          vim.keymap.set('n', 'ct', function()
            sidebar:apply(true)
          end, { 
            buffer = sidebar.containers.result.bufnr,
            desc = 'Accept Change',
            noremap = true,
            silent = true 
          })
          
          vim.keymap.set('n', 'co', function() 
            sidebar:apply(false)
          end, { 
            buffer = sidebar.containers.result.bufnr,
            desc = 'Reject Change',
            noremap = true, 
            silent = true 
          })
        end
      end
      
      -- Set up keymaps when Avante opens
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AvanteViewBufferUpdated',
        callback = setup_approval_keymaps,
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
      'saghen/blink.cmp',
      'ibhagwan/fzf-lua',
      'stevearc/dressing.nvim',
      'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
      -- ⚠️ Note: run :Copilot auth once to authenticate Copilot
      'zbirenbaum/copilot.lua',
      {
        'HakonHarnes/img-clip.nvim',
        ft = { 'markdown', 'org', 'tex', 'typst', 'rst' },
        cmd = { 'PasteImage', 'ImgClipConfig' },
        keys = {
          { '<leader>pi', '<cmd>PasteImage<cr>', desc = '[P]aste [I]mage from clipboard' },
        },
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
    --{
    --  -- Make sure to set this up properly if you have lazy=true
    --  'MeanderingProgrammer/render-markdown.nvim',
    --  opts = {
    --    file_types = { 'markdown', 'Avante' },
    --  },
    --  ft = { 'markdown', 'Avante' },
    --},
  },
  {
    'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { 'go', 'javascript', 'python', 'ruby' },
    cond = function()
      return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
    end,
    opts = {
      statusline = {
        enabled = true,
      },
    },
    code_suggestions = {
      -- For the full list of default languages, see the 'auto_filetypes' array in
      -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
      auto_filetypes = { 'ruby', 'go', 'zig', 'typescript', 'html' },
      ghost_text = {
        enabled = false,
        toggle_enabled = '<C-g><C-e>',
        accept_suggestion = '<C-g><C-a>',
        clear_suggestions = '<C-g><C-c>',
        stream = true,
      },
    },
  },
}
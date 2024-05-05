return {
  'David-Kunz/gen.nvim',
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>gn', ':Gen<CR>', { desc = '[G]e[n]erate text based on predefined and customizable prompts' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gw', ':Gen Enhance_Wording<CR>', { desc = '[G]enerate based on enhance [W]ording prompts' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gr', ':Gen Review_Code<CR>', { desc = '[G]enerate based on [R]eview code prompts' })
    require('gen').setup {
      model = 'llama3', -- The default model to use.
      host = 'localhost', -- The host running the Ollama service.
      port = '11434', -- The port on which the Ollama service is listening.
      quit_map = 'q', -- set keymap for close the response window
      retry_map = '<c-r>', -- set keymap to re-send the current prompt
      -- init = function(options)
      --   pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
      -- end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      display_mode = 'float', -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      debug = false, -- Prints errors and the command which is run.
    }
    require('gen').prompts['AWS Help'] = {
      prompt = 'You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: AWS, CDK, typescript, golang, rust. You answer with code examples when possible. $input:\n$text',
      replace = true,
    }
    require('gen').prompts['Developer Help'] = {
      prompt = 'You are a senior developer, acting as an assistant. You offer help with cloud technologies like: typescript, golang, rust, zig, Angular, React, webpack. You answer with code examples when possible. $input:\n$text',
      replace = true,
    }
  end,
}

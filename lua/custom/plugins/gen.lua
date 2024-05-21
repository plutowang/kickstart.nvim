return {
  'David-Kunz/gen.nvim',
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<C-g><C-g>', ':Gen<CR>', { desc = '[G]enerate text based on predefined and customizable prompts' })
    vim.keymap.set({ 'n', 'v' }, '<C-g><C-w>', ':Gen Enhance_Wording<CR>', { desc = '[G]enerate based on enhance [W]ording prompts' })
    vim.keymap.set({ 'n', 'v' }, '<C-g><C-r>', ':Gen Review_Code<CR>', { desc = '[G]enerate based on [R]eview code prompts' })
    vim.keymap.set({ 'n', 'v' }, '<C-g><A-c>', ':Gen Generate_Comments<CR>', { desc = '[G]enerate [C]omments' })
    vim.keymap.set({ 'n', 'v' }, '<C-g><C-t><A-c>', ':Gen Translate_Into_Chinese<CR>', { desc = '[G]enerate [T]ranslate into [C]hinese' })
    vim.keymap.set({ 'n', 'v' }, '<C-g><C-t>', ':Gen Translate_Into<CR>', { desc = '[G]enerate [T]ranslate into...' })
    vim.keymap.set({ 'n', 'v' }, '<C-g><C-m>', ':Gen Multi_Language_Translate<CR>', { desc = '[G]enerate [M]ulti Language Translate' })
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
      replace = false,
    }
    require('gen').prompts['Developer Help'] = {
      prompt = 'You are a senior developer, acting as an assistant. You offer help with cloud technologies like: typescript, golang, rust, zig, Angular, React, webpack. You answer with code examples when possible. $input:\n$text',
      replace = false,
    }
    require('gen').prompts['Generate_Comments'] = {
      prompt = 'You are a senior developer, acting as an assistant. You generate comments in format $filetype language: $filetype\n$text\n',
      replace = false,
      extract = "```$filetype\n(.-)```",
    }
    require('gen').prompts['Translate_Into_Chinese'] = {
      prompt = 'You are a professional interpreter and senior developer, acting as an assistant. Note the input text maybe in programing comment, please only withdraw text. You translate the following input text into Simplified Chinese:\n"$text"\n',
      replace = false,
    }
    require('gen').prompts['Translate_Into'] = {
      prompt = 'You are a professional interpreter and senior developer, acting as an assistant. Note the input text maybe in programing comment, please only withdraw text. You translate the following input text into $input:\n"$text"\n',
      replace = false,
    }
    require('gen').prompts['Multi_Language_Translate'] = {
      prompt = 'You are a professional interpreter and senior developer, acting as an assistant. Please translate following text into en,es,fr,Simplified Chinese, each language only keep one result, the output should only include the translation results, and all translation in the same line and split with comma:\n"$text"\n',
      replace = false,
    }
  end,
}

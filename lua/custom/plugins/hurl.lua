return {
    {
      "jellydn/hurl.nvim",
      enabled = function()
          if vim.fn.has 'win32' == 1 then
              return true
          end
          return false
      end,
      dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-treesitter/nvim-treesitter"
      },
      ft = "hurl",
      opts = {
          -- Show debugging info
          debug = false,
          -- Show notification on run
          show_notification = false,
          -- Show response in popup or split
          mode = "split",
          -- Default formatter
          formatters = {
              json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
              html = {
                  'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
                  '--parser',
                  'html',
              },
          },
          env_file = {
              '.env',
          },
      },
      keys = {
          -- Run API request
          { "<leader>ra", "<cmd>HurlRunner<CR>", desc = "[R]un [A]ll requests" },
          { "<leader>rr", "<cmd>HurlRunnerAt<CR>", desc = "[R]un Api [r]equest" },
          --{ "<leader>rre", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
          --{ "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
          { "<leader>rv", "<cmd>HurlVerbose<CR>", desc = "[R]un Api in [v]erbose mode" },
          { "<leader>rs", "<cmd>HurlSetEnvFile<CR>", desc = "[R]est [S]elect Env File" },
          -- Run Hurl request in visual mode
          --{ "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
      },
    }
}
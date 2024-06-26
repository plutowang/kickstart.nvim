return {
    {
      "m4xshen/hardtime.nvim",
      event = "VeryLazy",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
      opts = {
          disabled_filetypes = {
              "NvimTree",
              "TelescopePrompt",
              "aerial",
              "alpha",
              "checkhealth",
              "dapui*",
              "Diffview*",
              "Dressing*",
              "help",
              "httpResult",
              "lazy",
              "Neogit*",
              "mason",
              "neotest-summary",
              "minifiles",
              "neo-tree",
              "netrw",
              "noice",
              "notify",
              "prompt",
              "qf",
              "oil",
              "undotree",
              "Trouble",
              "startuptime"
          }
      }
    }
}
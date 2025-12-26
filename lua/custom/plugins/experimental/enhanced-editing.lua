return {
  -- Smart text objects for enhanced editing
  {
    'chrisgrieser/nvim-various-textobjs',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = { 'gc' }, -- Avoid conflicts with commenting
    },
  },
  {
    'gisketch/triforce.nvim',
    dependencies = { 'nvzone/volt' },
    keys = {
        {
            '<leader>tp', desc = '[T]oggle [P]rofile',
        }
    },
    config = function()
        require('triforce').setup({
            -- Optional: Add your configuration here
            keymap = {
                show_profile = '<leader>tp', -- Open profile with <leader>tp
            },
        })
    end,
  }
}
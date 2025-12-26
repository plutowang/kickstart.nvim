return {
  'kndndrj/nvim-dbee',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install the database binary
    require('dbee').install()
  end,
  config = function()
    local dbee = require 'dbee'

    -- Get DB from environment variable (try $DB first, then $DATABASE)
    local db_url = vim.fn.getenv 'DB'
    if db_url == vim.NIL or db_url == '' then
      db_url = vim.fn.getenv 'DATABASE'
    end
    if db_url == vim.NIL or db_url == '' then
        db_url = vim.fn.getenv 'POSTGRES'
    end

    local sources = {}

    -- If database URL exists, add it as default connection
    if db_url ~= vim.NIL and db_url ~= '' then
      -- Parse the database type from URL scheme
      local db_type = db_url:match '^(%w+)://'

      -- Map common URL schemes to dbee types
      local type_map = {
        postgresql = 'postgres',
        postgres = 'postgres',
        mysql = 'mysql',
        sqlite = 'sqlite',
        sqlserver = 'sqlserver',
        mssql = 'sqlserver',
        mongodb = 'mongo',
        mongo = 'mongo',
        redis = 'redis',
      }

      local connection_type = type_map[db_type] or db_type

      table.insert(
        sources,
        require('dbee.sources').MemorySource:new {
          {
            name = 'default',
            type = connection_type,
            url = db_url,
          },
        }
      )
    end

    dbee.setup {
      sources = sources,
    }
  end,
  keys = {
    {
      '<leader>Dt',
      function()
        require('dbee').toggle()
      end,
      desc = '[D]atabase [T]oggle UI',
    },
    {
        '<leader>Dc',
        function()
            require('dbee').close()
        end,
        desc = '[D]atabase [C]lose',
    },
    {
      '<leader>De',
      function()
        require('dbee').execute()
      end,
      desc = '[D]atabase [E]xecute Query',
    },
  },
}


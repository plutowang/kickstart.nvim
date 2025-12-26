-- Enhanced Debugging for Go, Rust & Zig
return {{
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {'nvim-neotest/nvim-nio'},
        opts = {
            icons = {
                expanded = '󰅀',
                collapsed = '󰅂',
                current_frame = '󰁕'
            },
            controls = {
                enabled = true,
                element = 'repl',
                icons = {
                    pause = '󰏤',
                    play = '󰐊',
                    step_into = '󰆹',
                    step_over = '󰆷',
                    step_out = '󰆸',
                    step_back = '󰜢',
                    run_last = '󰑮',
                    terminate = '󰝤',
                    disconnect = '󰖟'
                }
            },
            layouts = {{
                elements = {{
                    id = 'scopes',
                    size = 0.25
                }, {
                    id = 'breakpoints',
                    size = 0.25
                }, {
                    id = 'stacks',
                    size = 0.25
                }, {
                    id = 'watches',
                    size = 0.25
                }},
                size = 40,
                position = 'left'
            }, {
                elements = {{
                    id = 'repl',
                    size = 0.5
                }, {
                    id = 'console',
                    size = 0.5
                }},
                size = 0.25,
                position = 'bottom'
            }},
            floating = {
                max_height = nil,
                max_width = nil,
                border = 'rounded',
                mappings = {
                    close = {'q', '<Esc>'}
                }
            },
            windows = {
                indent = 2
            },
            render = {
                max_type_length = nil,
                max_value_lines = 100
            }
        }
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {'mason-org/mason.nvim'},
        opts = {
            automatic_installation = true,
            ensure_installed = {
                'delve', -- Go debugger
                'codelldb' -- Rust & Zig debugger
            },
            handlers = {}
        }
    },
    {
        'leoluz/nvim-dap-go',
        ft = 'go',
        opts = {
            delve = {
                detached = vim.fn.has 'win32' == 0,
                build_flags = {'-tags', 'debug'}
            },
            dap_configurations = {{
                type = 'go',
                name = ' Debug Package',
                request = 'launch',
                program = '${workspaceFolder}'
            }, {
                type = 'go',
                name = '󰙨 Debug Test',
                request = 'launch',
                mode = 'test',
                program = '${workspaceFolder}'
            }, {
                type = 'go',
                name = '󰈔 Debug File',
                request = 'launch',
                program = '${file}'
            }, {
                type = 'go',
                name = '󰌘 Attach Remote',
                mode = 'remote',
                request = 'attach'
            }}
        }
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
            enabled = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            only_first_definition = true,
            clear_on_continue = false,
            display_callback = function(variable)
                local value = variable.value or ""
                if #value > 50 then
                    value = value:sub(1, 47) .. "..."
                end
                return ' = ' .. value
            end,
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil
        },
        config = function(_, opts)
            require('nvim-dap-virtual-text').setup(opts)
            
            -- Hover state management
            local hover_enabled = true
            
            -- Elegant cursor hover for variable inspection
            local function show_hover()
                local word = vim.fn.expand('<cword>')
                local session = require('dap').session()
                if not word or word == '' or not session then return end
                
                session:request('evaluate', { expression = word, context = 'hover' }, function(err, resp)
                    if err or not resp or not resp.result then return end
                    
                    local content = ('󰍉 %s = %s'):format(word, resp.result)
                    if resp.type then content = content .. ('\n󰋼 %s'):format(resp.type) end
                    
                    vim.lsp.util.open_floating_preview({content}, 'markdown', {
                        border = 'rounded',
                        title = ' Debug Value ',
                        title_pos = 'center',
                        close_events = {'CursorMoved', 'CursorMovedI', 'InsertEnter'}
                    })
                end)
            end
            
            -- Toggle hover functionality
            local function toggle_hover()
                hover_enabled = not hover_enabled
                local status = hover_enabled and '󰄬 Enabled' or '󰄭 Disabled'
                vim.notify('󰍉 Debug Hover: ' .. status, vim.log.levels.INFO, { title = 'DAP' })
            end
            
            -- Simple REPL evaluation
            local function eval_repl()
                local word = vim.fn.expand('<cword>')
                if word and word ~= '' then
                    require('dap').repl.execute('p ' .. word)
                end
            end
            
            -- 󰐊 Auto-hover on cursor hold
            vim.api.nvim_create_autocmd('CursorHold', {
                group = vim.api.nvim_create_augroup('DapHover', { clear = true }),
                callback = function() 
                    if hover_enabled and require('dap').session() then 
                        show_hover() 
                    end 
                end
            })
            
            -- Keybindings
            vim.keymap.set('n', '<leader>dv', toggle_hover, { desc = 'Debug: Toggle variable hover', silent = true })
            vim.keymap.set('n', '<leader>dr', eval_repl, { desc = 'Debug: Evaluate in REPL', silent = true })
        end
    }},

    keys = {
      -- Function keys for quick debugging
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: See last session result.' },
      
      -- Variable inspection
      { '<leader>dv', desc = 'Debug: Toggle variable hover' },
      { '<leader>dr', desc = 'Debug: Evaluate variable in REPL' },

      -- Core debugging controls
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle [D]ebug [B]reakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = '[D]ebug [B]reakpoint Conditional' },
      { '<leader>dx', function() require('dap').clear_breakpoints() end, desc = '[D]ebug Clear All Breakpoints' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = '[D]ebug Run to [C]ursor' },
      { '<leader>dl', function() require('dap').run_last() end, desc = '[D]ebug Run [L]ast' },
      { '<leader>dt', function() require('dap').terminate() end, desc = '[D]ebug [T]erminate' },
      { '<leader>dp', function() require('dap').pause() end, desc = '[D]ebug [P]ause' },

      -- F-key equivalents grouped together
      { '<leader>dfc', function() require('dap').continue() end, desc = '<F5> [D]ebug [C]ontinue/Start' },
      { '<leader>dfi', function() require('dap').step_into() end, desc = '<F1> [D]ebug Step [I]nto' },
      { '<leader>dfO', function() require('dap').step_over() end, desc = '<F2> [D]ebug Step [O]ver' },
      { '<leader>dfo', function() require('dap').step_out() end, desc = '<F3> [D]ebug Step [O]ut' },
      { '<leader>dfu', function() 
        -- Check if debug UI is currently closed, and if so, close Neo-tree before opening
        local dapui = require 'dapui'
        local current_wins = vim.api.nvim_list_wins()
        local dap_ui_open = false
        for _, win in ipairs(current_wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match 'dap%-' then
            dap_ui_open = true
            break
          end
        end
        -- If DAP UI is not open, close Neo-tree before opening it
        if not dap_ui_open then
          local neo_tree_ok, neo_tree = pcall(require, 'neo-tree.command')
          if neo_tree_ok then
            neo_tree.execute { action = 'close' }
          end
        end
        dapui.toggle()
      end, desc = '<F7> [D]ebug [U]I Toggle' },

      -- Inspection tools
      { '<leader>dir', function() require('dap').repl.toggle() end, desc = '[D]ebug [I]nspection Toggle [R]EPL' },
      { '<leader>dis', function() require('dap').session() end, desc = '[D]ebug [I]nspection [S]ession Info' },
      { '<leader>diw', function() require('dap.ui.widgets').hover() end, desc = '[D]ebug [I]nspection [W]idget Hover' },
      { '<leader>diW', function() local widgets = require 'dap.ui.widgets'; widgets.centered_float(widgets.scopes) end, desc = '[D]ebug [I]nspection [W]idget Scopes' },
      { '<leader>diE', function() require('dapui').eval() end, desc = '[D]ebug [I]nspection [E]val Expression', mode = {'n', 'v'} },

      -- Go-specific debugging
      { '<leader>dgt', function() require('dap-go').debug_test() end, desc = '[D]ebug [G]o [T]est', ft = 'go' },
      { '<leader>dgl', function() require('dap-go').debug_last_test() end, desc = '[D]ebug [G]o [L]ast Test', ft = 'go' },
    },

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Catppuccin-styled breakpoint icons
        local breakpoint_icons = {
            Breakpoint = '●',
            BreakpointCondition = '◐',
            BreakpointRejected = '◌',
            LogPoint = '◆',
            Stopped = '▶'
        }

        for name, icon in pairs(breakpoint_icons) do
            local hl = name == 'Stopped' and 'DiagnosticWarn' or 'DiagnosticError'
            vim.fn.sign_define('Dap' .. name, {
                text = icon,
                texthl = hl,
                numhl = hl
            })
        end

        -- Auto-open/close DAP UI with notifications
        dap.listeners.after.event_initialized['dapui_config'] = function()
            -- Close Neo-tree if it's open
            local neo_tree_ok, neo_tree = pcall(require, 'neo-tree.command')
            if neo_tree_ok then
                neo_tree.execute {
                    action = 'close'
                }
            end

            dapui.open()
            vim.notify('󰃤 Debug session started', vim.log.levels.INFO, {
                title = 'DAP'
            })
        end

        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
            vim.notify('󰄬 Debug session terminated', vim.log.levels.INFO, {
                title = 'DAP'
            })
        end

        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
            vim.notify('󰙨 Debug session exited', vim.log.levels.INFO, {
                title = 'DAP'
            })
        end

        -- Rust debugging configuration
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'codelldb',
                args = {'--port', '${port}'}
            }
        }

        -- Helper functions for project path detection
        local function find_project_root(project_file)
            local file_path = vim.fn.findfile(project_file, '.;')
            if file_path == '' then
                return nil
            end
            return vim.fn.fnamemodify(file_path, ':h')
        end
        
        local function build_project(project_type, is_test)
            if project_type == 'rust' then
                local cmd = is_test and 'cargo test --no-run' or 'cargo build'
                vim.notify('󰜎 Building Rust project...', vim.log.levels.INFO, { title = 'DAP' })
                vim.fn.system(cmd)
            elseif project_type == 'zig' then
                local cmd = is_test and 'zig build test' or 'zig build'
                vim.notify('󰜎 Building Zig project...', vim.log.levels.INFO, { title = 'DAP' })
                vim.fn.system(cmd)
            end
        end
        
        local function get_executable_input(project_file, relative_path, fallback_path, prompt, project_type, is_test)
            -- Build project first
            if project_type then
                build_project(project_type, is_test)
            end
            
            local project_root = find_project_root(project_file)
            local target_path = project_root and (project_root .. '/' .. relative_path) or fallback_path
            return vim.fn.input(prompt, target_path, 'file')
        end

        -- Rust debugging configuration
        dap.configurations.rust = {{
            name = '󱘗 Launch Rust',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return get_executable_input('Cargo.toml', 'target/debug/', vim.fn.getcwd() .. '/target/debug/', 'Path to executable: ', 'rust', false)
            end,
            cwd = '${workspaceFolder}',
            args = {},
            stopOnEntry = false
        }, {
            name = '󰙨 Debug Rust Tests',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return get_executable_input('Cargo.toml', 'target/debug/deps/', vim.fn.getcwd() .. '/target/debug/deps/', 'Path to test executable: ', 'rust', true)
            end,
            cwd = '${workspaceFolder}',
            args = { '--nocapture' },
            stopOnEntry = false
        }}

        -- Zig debugging configuration
        dap.configurations.zig = {{
            name = '󰠳 Launch Zig',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return get_executable_input('build.zig', 'zig-out/bin/', vim.fn.getcwd() .. '/zig-out/bin/', 'Path to executable: ', 'zig', false)
            end,
            cwd = '${workspaceFolder}',
            args = {},
            stopOnEntry = false
        }, {
            name = '󰙨 Debug Zig Tests',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return get_executable_input('build.zig', 'zig-out/bin/', vim.fn.getcwd() .. '/zig-out/bin/', 'Path to test executable: ', 'zig', true)
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }}

    end
}}


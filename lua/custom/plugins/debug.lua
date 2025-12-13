-- 🐛 Enhanced Debugging for Go, Rust & Zig
return {{
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = { -- Debugging UI
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
    }, -- Mason integration for debug adapters
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {'mason-org/mason.nvim'},
        opts = {
            automatic_installation = true,
            ensure_installed = {'delve', -- Go debugger
            'codelldb' -- Rust & Zig debugger
            },
            handlers = {}
        }
    }, -- Go debugging support
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
                name = '🐹 Debug Package',
                request = 'launch',
                program = '${workspaceFolder}'
            }, {
                type = 'go',
                name = '🧪 Debug Test',
                request = 'launch',
                mode = 'test',
                program = '${workspaceFolder}'
            }, {
                type = 'go',
                name = '📄 Debug File',
                request = 'launch',
                program = '${file}'
            }, {
                type = 'go',
                name = '🔗 Attach Remote',
                mode = 'remote',
                request = 'attach'
            }}
        }
    }, -- Virtual text for variable inspection with cursor hover
    {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            clear_on_continue = false,
            display_callback = function(variable, buf, stackframe, node, options)
                -- Limit value length for readability
                local value = variable.value or ""
                if #value > 50 then
                    value = value:sub(1, 47) .. "..."
                end
                
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. value
                else
                    return variable.name .. ' = ' .. value
                end
            end,
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil
        },
        config = function(_, opts)
            require('nvim-dap-virtual-text').setup(opts)
            
            -- Add cursor hover functionality for variable inspection
            local dap = require('dap')
            
            -- Function to show variable value in floating window
            local function show_variable_hover()
                local word = vim.fn.expand('<cword>')
                if not word or word == '' then return end
                
                -- Get current session
                local session = dap.session()
                if not session then return end
                
                -- Request variable evaluation
                session:request('evaluate', {
                    expression = word,
                    context = 'hover',
                }, function(err, resp)
                    if err or not resp or not resp.result then return end
                    
                    local lines = {}
                    table.insert(lines, '📊 ' .. word .. ' = ' .. resp.result)
                    if resp.type then
                        table.insert(lines, '📋 Type: ' .. resp.type)
                    end
                    
                    -- Create floating window
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                    
                    local opts_float = {
                        relative = 'cursor',
                        width = math.max(25, #lines[1] + 5),
                        height = #lines,
                        row = 1,
                        col = 0,
                        style = 'minimal',
                        border = 'rounded',
                        title = ' Variable Value ',
                        title_pos = 'center',
                    }
                    
                    local win = vim.api.nvim_open_win(buf, false, opts_float)
                    
                    -- Set highlight
                    vim.api.nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat,FloatBorder:FloatBorder')
                    
                    -- Auto-close after 4 seconds or on cursor move
                    local timer = vim.loop.new_timer()
                    local closed = false
                    
                    local function close_window()
                        if closed then return end
                        closed = true
                        if timer then timer:stop() end
                        if vim.api.nvim_win_is_valid(win) then
                            vim.api.nvim_win_close(win, true)
                        end
                        if vim.api.nvim_buf_is_valid(buf) then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end
                    
                    -- Close on timer
                    timer:start(4000, 0, vim.schedule_wrap(close_window))
                    
                    -- Close on cursor move
                    local close_autocmd = vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI', 'WinLeave'}, {
                        once = true,
                        callback = function()
                            close_window()
                        end,
                    })
                end)
            end
            
            -- Function to get variable value under cursor for REPL
            local function evaluate_in_repl()
                local word = vim.fn.expand('<cword>')
                if word and word ~= '' then
                    require('dap').repl.execute('p ' .. word)
                    require('dapui').open({ reset = false })
                    -- Focus on REPL
                    vim.defer_fn(function()
                        local wins = vim.api.nvim_list_wins()
                        for _, win in ipairs(wins) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            local buf_name = vim.api.nvim_buf_get_name(buf)
                            if buf_name:match('dap%-repl') then
                                vim.api.nvim_set_current_win(win)
                                break
                            end
                        end
                    end, 100)
                end
            end
            
            -- Set up autocommands for hover functionality
            local group = vim.api.nvim_create_augroup('DapVariableHover', { clear = true })
            
            -- Show variable on cursor hold (when debugging)
            vim.api.nvim_create_autocmd('CursorHold', {
                group = group,
                callback = function()
                    if require('dap').session() then
                        show_variable_hover()
                    end
                end,
            })
            
            -- Keybinding for manual variable inspection
            vim.keymap.set('n', '<leader>dv', show_variable_hover, { 
                desc = 'Debug: Show variable value',
                silent = true 
            })
            
            -- Keybinding for evaluating expression in REPL
            vim.keymap.set('n', '<leader>dr', evaluate_in_repl, { 
                desc = 'Debug: Evaluate in REPL',
                silent = true 
            })
        end
    }},

    keys = {
      -- 🎯 Function keys for quick debugging
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: See last session result.' },
      
      -- 🔍 Variable inspection
      { '<leader>dv', desc = 'Debug: Show variable value (hover)' },
      { '<leader>dr', desc = 'Debug: Evaluate variable in REPL' },

      -- 🎯 Core debugging controls
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle [D]ebug [B]reakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = '[D]ebug [B]reakpoint Conditional' },
      { '<leader>dx', function() require('dap').clear_breakpoints() end, desc = '[D]ebug Clear All Breakpoints' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = '[D]ebug Run to [C]ursor' },
      { '<leader>dl', function() require('dap').run_last() end, desc = '[D]ebug Run [L]ast' },
      { '<leader>dt', function() require('dap').terminate() end, desc = '[D]ebug [T]erminate' },
      { '<leader>dp', function() require('dap').pause() end, desc = '[D]ebug [P]ause' },

      -- 🚀 F-key equivalents grouped together
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

      -- 🔍 Inspection tools
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

        -- 🎨 Catppuccin-styled breakpoint icons
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

        -- 🔧 Auto-open/close DAP UI with notifications
        dap.listeners.after.event_initialized['dapui_config'] = function()
            -- Close Neo-tree if it's open
            local neo_tree_ok, neo_tree = pcall(require, 'neo-tree.command')
            if neo_tree_ok then
                neo_tree.execute {
                    action = 'close'
                }
            end

            dapui.open()
            vim.notify('🐛 Debug session started', vim.log.levels.INFO, {
                title = 'DAP'
            })
        end

        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
            vim.notify('✅ Debug session terminated', vim.log.levels.INFO, {
                title = 'DAP'
            })
        end

        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
            vim.notify('🏁 Debug session exited', vim.log.levels.INFO, {
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

        dap.configurations.rust = {{
            name = '🦀 Launch Rust',
            type = 'codelldb',
            request = 'launch',
            program = function()
                local metadata = vim.fn.system 'cargo metadata --format-version 1 --no-deps'
                local json = vim.fn.json_decode(metadata)
                local target_dir = json.target_directory
                local workspace_root = json.workspace_root

                local targets = {}
                for _, package in ipairs(json.packages) do
                    for _, target in ipairs(package.targets) do
                        if vim.tbl_contains(target.kind, 'bin') then
                            table.insert(targets, target.name)
                        end
                    end
                end

                if #targets == 1 then
                    return target_dir .. '/debug/' .. targets[1]
                elseif #targets > 1 then
                    local choice = vim.fn.inputlist(vim.list_extend({'Select binary:'}, vim.tbl_map(function(t)
                        return '  ' .. t
                    end, targets)))
                    if choice > 0 and choice <= #targets then
                        return target_dir .. '/debug/' .. targets[choice]
                    end
                end

                return vim.fn.input('Path to executable: ', target_dir .. '/debug/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {}
        }, {
            name = '🧪 Debug Rust Tests',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/target/debug/deps/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }}

        -- ⚡ Zig debugging configuration
        dap.configurations.zig = {{
            name = '⚡ Launch Zig',
            type = 'codelldb',
            request = 'launch',
            program = function()
                -- Try to find zig-out/bin directory first
                local zig_out = vim.fn.getcwd() .. '/zig-out/bin'
                if vim.fn.isdirectory(zig_out) == 1 then
                    local files = vim.fn.globpath(zig_out, '*', false, true)
                    local executables = vim.tbl_filter(function(file)
                        return vim.fn.executable(file) == 1
                    end, files)

                    if #executables == 1 then
                        return executables[1]
                    elseif #executables > 1 then
                        local basenames = vim.tbl_map(function(f)
                            return vim.fn.fnamemodify(f, ':t')
                        end, executables)
                        local choice = vim.fn.inputlist(vim.list_extend({'Select executable:'}, vim.tbl_map(function(t)
                            return '  ' .. t
                        end, basenames)))
                        if choice > 0 and choice <= #executables then
                            return executables[choice]
                        end
                    end
                end

                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {}
        }, {
            name = '🧪 Debug Zig Tests',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }}

        -- Enhanced debugging experience
        dap.defaults.fallback.external_terminal = {
            command = '/usr/bin/alacritty',
            args = {'-e'}
        }
    end
}}


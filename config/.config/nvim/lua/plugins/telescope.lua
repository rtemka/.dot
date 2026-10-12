return { -- Главный плагин Telescope
{
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {'nvim-lua/plenary.nvim', {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    }},
    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false
                    }
                }
            }
        }

        -- Включаем fzf extension (если скомпилировался)
        pcall(require('telescope').load_extension, 'fzf')

        -- горячие клавиши (keymaps)
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>?', builtin.oldfiles, {
            desc = '[?] Find recently opened files'
        })
        vim.keymap.set('n', '<leader><space>', builtin.buffers, {
            desc = '[ ] Find existing buffers'
        })

        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false
            })
        end, {
            desc = '[/] Fuzzily search in current buffer'
        })

        vim.keymap.set('n', '<leader>gf', builtin.git_files, {
            desc = 'Search [G]it [F]iles'
        })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, {
            desc = '[S]earch [F]iles'
        })
        vim.keymap.set('n', '<leader>scf', function()
            builtin.find_files({
                cwd = vim.fn.expand('%:p:h')
            })
        end, {
            desc = '[S]earch [C]urrent Directory [F]iles'
        })

        vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
            desc = '[S]earch [H]elp'
        })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
            desc = '[S]earch current [W]ord'
        })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
            desc = '[S]earch by [G]rep'
        })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
            desc = '[S]earch [D]iagnostics'
        })
        vim.keymap.set('n', '<leader>sr', builtin.resume, {
            desc = '[S]earch [R]resume'
        })
    end
}, -- Расширение File Browser
{
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    config = function()
        -- Включаем расширение файлового браузера
        pcall(require('telescope').load_extension, 'file_browser')

        -- биндинги для файлового браузера
        vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', {
            noremap = true,
            desc = '[F]ile [B]rowser relative to buffer'
        })
        vim.keymap.set('n', '<leader>frb', ':Telescope file_browser<CR>', {
            noremap = true,
            desc = '[F]ile [R]oot [B]rowser'
        })
    end
}}

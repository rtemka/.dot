return {{
    'rebelot/kanagawa.nvim',
    priority = 990,
    config = function()
        vim.cmd.colorscheme 'kanagawa' -- or kanagawa-wave or kanagawa-dragon or kanagawa-lotus
    end
}, -- {
--     'sainnhe/everforest',
--     priority = 993,
--     config = function()
--         vim.cmd.colorscheme 'everforest'
--     end,
-- },
{
    'rose-pine/neovim',
    priority = 995,
    config = function()
        vim.cmd.colorscheme 'rose-pine'
    end
}, {
    "catppuccin/nvim",
    priority = 992,
    config = function()
        vim.cmd.colorscheme 'catppuccin'
    end
}, -- {
--     'shaunsingh/nord.nvim',
--     priority = 997,
--     config = function()
--         vim.cmd.colorscheme 'nord'
--     end,
-- },
--
-- {
--     'ellisonleao/gruvbox.nvim',
--     priority = 998,
--     config = function()
--         vim.cmd.colorscheme 'gruvbox'
--     end,
-- },
--
{
    'nvim-tree/nvim-web-devicons',
    opts = {}
}, {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    config = function()
        -- document existing key chains
        local wk = require("which-key")
        wk.add({{
            "<leader>f",
            group = "[F]ile Browser relative to opened buffer"
        }, {
            "<leader>F",
            group = "[F]ile Browser relative to directory"
        }, {
            "<leader>c",
            group = "[C]ode"
        }, {
            "<leader>d",
            group = "[D]ocument"
        }, {
            "<leader>g",
            group = "[G]it"
        }, {
            "<leader>h",
            group = "More git"
        }, {
            "<leader>r",
            group = "[R]ename"
        }, {
            "<leader>s",
            group = "[S]earch"
        }, {
            "<leader>w",
            group = "[W]orkspace"
        }, {
            "<leader>b",
            group = "buffers",
            expand = function()
                return require("which-key.extras").expand.buf()
            end
        }})
    end
}, {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = '|',
            section_separators = ''
        }
    }
}, {{
    -- Add indentation guides even on blank lines
    -- See `:help indent_blankline.txt`
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
}}, {
    'echasnovski/mini.nvim',
    version = false
}, {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    opts = {
        config = function()
            require('Comment').setup()
        end
    }
}, {
    -- terminal
    'akinsho/toggleterm.nvim',
    config = function()
        -- See: `:h toggleterm.txt`
        require("toggleterm").setup {
            size = 17,
            open_mapping = [[<C-\>]],
            direction = "float" -- horizontal
        }
    end
}}

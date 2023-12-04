return {
    -- vim blazingly fast training :=)
    { 'ThePrimeagen/vim-be-good' },

    --[[ {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
 ]]
    {
        'rebelot/kanagawa.nvim',
        priority = 994,
        config = function()
            vim.cmd.colorscheme 'kanagawa' -- or kanagawa-wave or kanagawa-dragon or kanagawa-lotus
        end,
    },

    {
        "catppuccin/nvim",
        priority = 995,
        config = function()
            vim.cmd.colorscheme 'catppuccin'
        end,
    },

    {
        'shaunsingh/nord.nvim',
        priority = 997,
        config = function()
            vim.cmd.colorscheme 'nord'
        end,
    },

    {
        'ellisonleao/gruvbox.nvim',
        priority = 998,
        config = function()
            vim.cmd.colorscheme 'gruvbox'
        end,
    },

    { 'nvim-tree/nvim-web-devicons', opts = {} },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim',        opts = {} },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'gruvbox-material',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        -- Add indentation guides even on blank lines
        -- See `:help indent_blankline.txt`
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',   opts = {} },
    -- terminal
    { 'akinsho/toggleterm.nvim', opts = {} },
}

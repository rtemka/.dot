return { {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    config = function()
        vim.lsp.config("*", {})
        vim.lsp.enable({ "gopls", "clangd", "yamlls", "lua_ls", "pylsp", "rust_analyzer", "ts_ls", "dockerls", "bashls",
            "html", "jsonls", "docker_compose_language_service" })
    end,
    dependencies = { -- Automatically install LSPs to stdpath for neovim
        {
            'williamboman/mason.nvim',
            config = true
        }, 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {}
        }, -- -- Additional lua configuration, makes nvim stuff amazing!
        -- { 'folke/neodev.nvim', enabled = false },
        {
            'folke/lazydev.nvim',
            enabled = true
        } }
} }

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local fmt_on_save_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        vim.lsp.buf.format()
    end,
    group = fmt_on_save_group
})

local go_fmt_group = vim.api.nvim_create_augroup('GoFormat', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function(args)
        -- Execute the organizeImports command for Go
        vim.lsp.buf.code_action({
            context = {
                only = { "source.organizeImports" },
                diagnostics = {},
            },
            apply = true, -- Apply the action automatically
            -- bufnr = vim.api.nvim_get_current_buf(),
            bufnr = args.buf,
        })
    end,
    group = go_fmt_group
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })
    end,
})

-- local code_lens_group = vim.api.nvim_create_augroup('LSPCodeLens', { clear = true })
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
--     callback = function()
--         vim.lsp.codelens.refresh()
--     end,
--     group = code_lens_group
-- })
--
--[[ Bash language server ]]
--[[ vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
}) ]]

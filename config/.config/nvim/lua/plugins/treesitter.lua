return {{
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        -- Автоустановка парсеров для ветки main
        vim.g.treesitter_ensure_installed = {'c', 'go', 'lua', 'rust', 'ocaml', 'vimdoc', 'vim', "bash", "yaml",
                                             "dockerfile", "markdown", "markdown_inline"}

        -- -- Включение подсветки и умных отступов
        -- -- Отдельно включаем подсветку для всех файловых типов
        -- vim.api.nvim_create_autocmd("FileType", {
        --     callback = function()
        --         pcall(vim.treesitter.start)
        --     end
        -- })

        -- -- Отдельно включаем treesitter indentexpr только для файловых типов,
        -- -- у которых есть парсер и indent-запросы (indents.scm)
        -- -- Для остальных файловых типов будет работать smartindent/autoindent из options.lua
        -- local indentable_filetypes = {"c", "cpp", "go", "lua", "rust", "ocaml", "vim", "bash", "python", "javascript",
        --                               "typescript", "java", "ruby", "html", "css", "json", "yaml", "toml", "markdown"}

        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = indentable_filetypes,
        --     callback = function()
        --         -- Проверяем, что парсер доступен и поддерживает indent
        --         local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
        --         if lang and pcall(vim.treesitter.get_parser, 0, lang) then
        --             vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
        --         end
        --     end
        -- })

        -- Инициализация Incremental Selection (встроенный в Neovim модуль)
        vim.keymap.set("n", "<c-space>", function()
            require("nvim-treesitter.incremental_selection").init_selection()
        end, {
            desc = "Init selection"
        })
        vim.keymap.set("x", "<c-space>", function()
            require("nvim-treesitter.incremental_selection").node_incremental()
        end, {
            desc = "Increment node"
        })
        vim.keymap.set("x", "<c-s>", function()
            require("nvim-treesitter.incremental_selection").scope_incremental()
        end, {
            desc = "Increment scope"
        })
        vim.keymap.set("x", "<M-space>", function()
            require("nvim-treesitter.incremental_selection").node_decremental()
        end, {
            desc = "Decrement node"
        })
    end
}, {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
        -- Отключаем стандартные конфликтующие биндинги ftplugin
        vim.g.no_plugin_maps = true

        -- Хелпер для создания textobjects (Select)
        local function map_select(lhs, query)
            vim.keymap.set({"x", "o"}, lhs, function()
                require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
            end)
        end

        -- Привязываем textobjects (выделение)
        map_select('aa', '@parameter.outer')
        map_select('ia', '@parameter.inner')
        map_select('af', '@function.outer')
        map_select('if', '@function.inner')
        map_select('ac', '@class.outer')
        map_select('ic', '@class.inner')

        -- Хелпер для перемещений (Move)
        local function map_move(lhs, query, method)
            vim.keymap.set("n", lhs, function()
                require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end)
        end

        -- Привязываем перемещения по коду (Move)
        map_move(']m', '@function.outer', 'goto_next_start')
        map_move(']]', '@class.outer', 'goto_next_start')
        map_move(']M', '@function.outer', 'goto_next_end')
        map_move('][', '@class.outer', 'goto_next_end')

        map_move('[m', '@function.outer', 'goto_previous_start')
        map_move('[[', '@class.outer', 'goto_previous_start')
        map_move('[M', '@function.outer', 'goto_previous_end')
        map_move('[]', '@class.outer', 'goto_previous_end')

        -- Хелпер для обмена местами (Swap)
        local function map_swap(lhs, query, method)
            vim.keymap.set("n", lhs, function()
                require("nvim-treesitter-textobjects.swap")[method](query, "textobjects")
            end)
        end

        -- Привязываем swap элементов
        map_swap('<leader>a', '@parameter.inner', 'swap_next')
        map_swap('<leader>A', '@parameter.inner', 'swap_previous')
    end
}}

-- Add jinja filetypes detection.
vim.filetype.add {
    extension = {
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'jinja'
    }
}

return {{
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {{
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        config = true
    }, 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
    'hrsh7th/cmp-nvim-lsp', -- Provides capabilities for LSP
    {
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {}
    }, {
        -- -- Additional lua configuration, makes nvim stuff amazing!
        -- { 'folke/neodev.nvim', enabled = false }
        'folke/lazydev.nvim',
        enabled = true
    }},
    config = function()
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        -- Set default capabilities for all LSP servers
        vim.lsp.config("*", {
            capabilities = cmp_nvim_lsp.default_capabilities()
        })

        vim.lsp.enable({"gopls", "clangd", "yamlls", "lua_ls", "pylsp", "rust_analyzer", "ts_ls", "dockerls", "bashls",
                        "html", "jsonls", "docker_compose_language_service", "jinja-lsp"})

        -- Go language server configuration with extended code actions
        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    gofumpt = true,
                    codelenses = {
                        gc_details = true,
                        generate = true,
                        regenerate_cgo = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                        vulncheck = true
                    },
                    analyses = {
                        fieldfill = true,
                        nilness = true,
                        nonewvars = true,
                        shadow = true,
                        undeclaredname = true,
                        unreachable = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true
                    },
                    staticcheck = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true
                    },
                    usePlaceholders = true
                }
            }
        })

        -- Lua language server configuration
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"},
                        severity = {
                            missing_fields = "Warning",
                            ambiguous_fields = "Warning",
                            duplicate_fields = "Error",
                            unused_local = "Warning",
                            unused_lua_providers = "Warning",
                            deprecated = "Warning",
                            code_after_break = "Warning",
                            reduce_init = "Hint"
                        },
                        delay = 500,
                        workspace = "Library"
                    },
                    completion = {
                        callSnippet = "Replace",
                        keywordSnippet = "Insert",
                        showObjectMembers = true
                    },
                    codeLens = {
                        enable = true
                    },
                    workspace = {
                        checkThirdPartyPkg = true,
                        maxPreload = 100000,
                        preloadFileSize = 50000
                    },
                    hint = {
                        enable = true,
                        setType = true,
                        paramType = true,
                        paramName = "Disable",
                        paramLabels = {
                            enable = true,
                            display = {"LiteralParameterLabel"}
                        },
                        arrayIndex = "Disable",
                        enabled = true,
                        semicolon = "Disable",
                        timeout = 1
                    },
                    telemetry = {
                        enable = false
                    }
                }
            }
        })

        -- Python language server configuration with linters
        vim.lsp.config("pylsp", {
            settings = {
                pylsp = {
                    plugins = {
                        -- Pycodestyle
                        pycodestyle = {
                            enabled = true,
                            maxLineLength = 100,
                            ignore = {"W503", "W504"}
                        },
                        -- Pyflakes
                        pyflakes = {
                            enabled = true
                        },
                        -- pylint
                        pylint = {
                            enabled = true,
                            args = true,
                            categories = "unmatched-groups-wildcard"
                        },
                        -- flake8
                        flake8 = {
                            enabled = true,
                            maxLineLength = 100
                        },
                        -- pydocstyle
                        pydocstyle = {
                            enabled = true,
                            convention = "pep257",
                            addIgnore = {},
                            addDeselect = {},
                            ignore = {"D100", "D101", "D102", "D103"}
                        },
                        -- mccabe
                        mccabe = {
                            enabled = true,
                            threshold = 15
                        },
                        -- autopep8
                        autopep8 = {
                            enabled = true,
                            maxLineLength = 100
                        },
                        -- isort
                        isort = {
                            enabled = true,
                            path = "",
                            maxSort = 50,
                            noSections = "",
                            order = "style",
                            relativeOrder = ""
                        },
                        -- jedi
                        jedi = {
                            enabled = true,
                            completeFunctionCalls = true,
                            typeshedPaths = {},
                            extraPaths = {},
                            loadUninstallablePackages = false,
                            preloadModules = {},
                            environment = "",
                            pluginPaths = {},
                            symbols = {},
                            extraSysPath = {}
                        },
                        -- rename
                        rename = {
                            enabled = true
                        }
                    }
                }
            }
        })

        -- C/C++ language server configuration
        vim.lsp.config("clangd", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            init_options = {
                abilities = {
                    fileRename = {
                        addExcludes = true,
                        moveFolders = true
                    },
                    inlayHints = true,
                    incrementalCompilation = true
                },
                clangdFileStatus = true,
                headersInPaths = true,
                index = "",
                inlayHints = {
                    typeHints = true,
                    parameterNameHints = "All",
                    chainedParameterNameHints = false,
                    lambdaParameterNameHints = false,
                    otherHints = true
                },
                compilationDatabasePath = "",
                buildConfig = "Default",
                useBuildServer = true,
                diagnosticDelay = 100,
                indexingQueueSize = 0
            },
            on_attach = function(client, bufnr)
                vim.keymap.set("n", "<leader>h", vim.lsp.inlay_hint.enable, {
                    buffer = bufnr,
                    desc = "Toggle Inlay [H]ints"
                })
            end
        })

        -- TypeScript/JavaScript language server configuration
        vim.lsp.config("ts_ls", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            settings = {
                javascript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsThatAreParameters = true,
                        includeInlayParameterNameHintsThatAreLiteral = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsThatAreDeclarations = true
                    },
                    preferences = {
                        importModuleSpecifiers = "auto",
                        importFinishTrailingComma = "always",
                        quoteStyle = "single",
                        organizeTscAttempts = "always"
                    },
                    completeFunctionCalls = {
                        includeAutoImplementedOptionalFields = true,
                        addMethodCallPrefix = true
                    },
                    format = {
                        indentSize = 4,
                        tabSize = 4,
                        insertSpaceAfterCommaDelimiter = true,
                        insertSpaceAfterSemicolonInForStatements = true,
                        insertSpaceBeforeAndAfterBinaryOperators = true,
                        insertSpaceAfterKeywordsInControlFlowStatements = true
                    }
                },
                typescript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsThatAreParameters = true,
                        includeInlayParameterNameHintsThatAreLiteral = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsThatAreDeclarations = true
                    },
                    preferences = {
                        importModuleSpecifiers = "auto",
                        importFinishTrailingComma = "always",
                        quoteStyle = "single",
                        organizeTscAttempts = "always"
                    },
                    completeFunctionCalls = {
                        includeAutoImplementedOptionalFields = true,
                        addMethodCallPrefix = true
                    },
                    format = {
                        indentSize = 4,
                        tabSize = 4,
                        insertSpaceAfterCommaDelimiter = true,
                        insertSpaceAfterSemicolonInForStatements = true,
                        insertSpaceBeforeAndAfterBinaryOperators = true,
                        insertSpaceAfterKeywordsInControlFlowStatements = true
                    }
                }
            }
        })

        -- Rust analyzer configuration
        vim.lsp.config("rust_analyzer", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                        allTargets = true,
                        noDefaultFeatures = false,
                        allFeatures = true
                    },
                    completions = {
                        completeFunctionCalls = true,
                        completeAttributes = true,
                        addCallParenthesis = true,
                        addCallArgumentName = true,
                        postfixes = {
                            enable = true
                        },
                        visibility = {
                            enums = true,
                            hideConstructors = true
                        },
                        imports = {
                            grantPackageDirective = true,
                            mergeGlobals = true,
                            preferNoStd = false,
                            preferPragmas = true,
                            preferPrelude = true,
                            scope = "all",
                            self = true
                        }
                    },
                    inlayHints = {
                        bindNameHints = {
                            all = true
                        },
                        closureCapture = "all",
                        closureReturnType = true,
                        closureShorthandAssumptions = {
                            paramNames = true,
                            paramTypes = true
                        },
                        discriminantHints = "all",
                        expressionTypeHints = {
                            chain = true
                        },
                        chainingHints = true,
                        closingBraceHints = {
                            minLines = 25
                        },
                        filteringAdapters = true,
                        lifetimeElision = "all",
                        parameterDuplicates = true,
                        rangeExhaustiveness = "all",
                        renderCollection = true,
                        sortCallHints = true,
                        sortTextables = true,
                        procMacro = {
                            enable = true,
                            enableAttrs = true
                        }
                    },
                    cargo = {
                        allFeatures = true,
                        autoLoadTargets = true,
                        featurePicker = "auto",
                        features = {},
                        loadOutputs = true,
                        noDefaultFeatures = false
                    },
                    files = {
                        watcher = "client"
                    }
                }
            }
        })

        -- YAML language server configuration
        vim.lsp.config("yamlls", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            settings = {
                yaml = {
                    schemas = {
                        kubernetes = "/*k8s*.yaml",
                        ["https://json.schemastore.org/github-workflow"] = "/.github/workflows/*.yml"
                    },
                    validate = true,
                    schemaStore = {
                        enable = true,
                        url = "https://www.schemastore.org/api/json/catalog.json"
                    },
                    customTags = {}
                }
            }
        })

        -- JSON language server configuration
        vim.lsp.config("jsonls", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            settings = {
                json = {
                    schemas = {},
                    validate = true,
                    format = {
                        enable = true
                    },
                    completeNumbers = true,
                    truncateProperties = false
                }
            }
        })

        -- HTML language server configuration
        vim.lsp.config("html", {
            capabilities = cmp_nvim_lsp.default_capabilities(),
            settings = {
                html = {
                    format = {
                        wrapLineLength = 0,
                        wrapAttributes = "auto",
                        contentFormat = "preserve",
                        unformatted = "wbr",
                        preserveNewlines = true
                    },
                    suggest = {
                        html5 = "v1",
                        completeTags = true,
                        completeAttributes = true,
                        completeAttributesWithSnippet = true
                    },
                    codeLens = {
                        enable = true
                    },
                    closeTags = {
                        autoClose = true,
                        closeSelfClosing = true
                    }
                }
            }
        })

        -- Dockerfile language server configuration
        vim.lsp.config("dockerls", {
            capabilities = cmp_nvim_lsp.default_capabilities()
        })

        -- Docker Compose language server configuration
        vim.lsp.config("docker_compose_language_service", {
            capabilities = cmp_nvim_lsp.default_capabilities()
        })

        -- Bash language server configuration
        vim.lsp.config("bashls", {
            capabilities = cmp_nvim_lsp.default_capabilities()
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', {
                clear = true
            }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, {
                        buffer = event.buf,
                        desc = 'LSP: ' .. desc
                    })
                end

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', {'n', 'x'})

                -- Find references for the word under your cursor.
                map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [R]e[D]efinition')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
            end
        })
    end
}}

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = true,
      codelens = true,
      inlay_hints = true,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {},
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000,
    },
    -- enable servers that you already have installed without mason
    servers = {},
    ---@diagnostic disable: missing-fields
    config = {
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
      rust_analyzer = {
        standalone = false,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              -- https://github.com/rust-analyzer/rust-analyzer/issues/6835
              disabled = { "unresolved-macro-call" },
              enableExperimental = true,
            },
            completion = {
              autoself = { enable = true },
              autoimport = { enable = true },
              postfix = { enable = true },
            },
            imports = {
              group = { enable = true },
              merge = { glob = false },
              prefix = "self",
              granularity = {
                enforce = true,
                group = "crate",
              },
            },
            cargo = {
              loadOutDirsFromCheck = true,
              autoreload = true,
              runBuildScripts = true,
              features = "all",
            },
            procMacro = { enable = true },
            lens = {
              enable = true,
              run = { enable = true },
              debug = { enable = true },
              implementations = { enable = true },
              references = {
                adt = { enable = true },
                enumVariant = { enable = true },
                method = { enable = true },
                trait = { enable = true },
              },
            },
            inlayHints = {
              enable = true,
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = {
                enable = true,
                minLines = 10,
              },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "skip_trivial" },
              parameterHints = { enable = false },
              typeHints = { enable = true },
            },
            check = {
              enable = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      },
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              autopep8 = { enabled = false },
              black = { enabled = false },
              jedi_completion = { fuzzy = true },
              pycodestyle = { enabled = false },
              pyflakes = { enabled = false },
              pylint = { enabled = false, executable = "pylint" },
              isort = { enabled = false },
              pylsp_mypy = { enabled = false },
              ruff = { enabled = false },
              rope_autoimport = { enabled = false },
              yapf = { enabled = false },
            },
          },
        },
      },
      sourcery = {
        settings = {
          sourcery = {
            metricsEnabled = false,
            refactor = {
              skip = {
                "function-quality",
              },
            },
          },
        },
      },
    },
    handlers = {
      rust_analyzer = false,
    },
    autocmds = {
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        {
          event = { "CursorHold", "CursorHoldI" },
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
    },
  },
}

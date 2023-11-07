return {
  setup_handlers = {
    rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
  },
  config = {
    -- I use eslint for js/ts formatting
    tsserver = {
      javascript = {
        format = {
          enable = false,
        },
      },
      typescript = {
        format = {
          enable = false,
        },
      },
    },
    eslint = {
      on_attach = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
          command = "silent! EslintFixAll",
        })
      end,
    },
    clangd = {
      capabilities = {
        offsetEncoding = "utf-8",
      },
    },
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
            bindingModeHints = { enable = true },
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
          checkOnSave = {
            enable = true,
            command = "clippy",
            features = "all",
          },
        },
      },
    },
  },
}

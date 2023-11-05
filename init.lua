--              AstroNvim Configuration Table
vim.opt.guifont = { "Iosevka", ":h14" }
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_remember_window_size = true

local config = {
  colorscheme = "catppuccin",
  options = {
    opt = {
      relativenumber = false,
      number = true,
    },
  },
  lsp = {
    setup_handlers = {
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
    },
    config = {
      -- I use rome for formatting
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
  },
  plugins = {
    {
      "catppuccin/nvim",
      as = "catppuccin",
      priority = 1000,
      lazy = false,
    },
    {
      "simrat39/rust-tools.nvim",
      after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
      event = "User AstroLspSetup",
    },
    {
      "saecki/crates.nvim",
      event = "BufRead Cargo.toml",
      after = "nvim-cmp",
      config = true,
    },
    {
      'David-Kunz/cmp-npm',
      event = "BufRead package.json",
      after = "nvim-cmp",
      opts = { ignore = { 'beta', 'rc' } },
    },
    {
      "hrsh7th/nvim-cmp",
      lazy = false,
      dependencies = {
        "zbirenbaum/copilot.lua",
      },
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sources = cmp.config.sources {
          { name = "crates",   priority = 1100 },
          { name = 'npm',      priority = 1100 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
        }
        opts.mapping = cmp.mapping.preset.insert {
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),
        }
        return opts
      end,
    },
    {
      "zbirenbaum/copilot.lua",
      lazy = false,
      opts = {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<TAB>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      }
    },
    {
      "RishabhRD/lspactions",
      lazy = false,
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
      },
      config = function()
        local lspactions = require "lspactions"

        vim.ui.select = lspactions.select
        vim.ui.input = lspactions.input

        vim.lsp.handlers["textDocument/codeAction"] = lspactions.codeaction
        vim.lsp.handlers["textDocument/references"] = lspactions.references
        vim.lsp.handlers["textDocument/definition"] = lspactions.definition
        vim.lsp.handlers["textDocument/declaration"] = lspactions.declaration
        vim.lsp.handlers["textDocument/implementation"] = lspactions.implementation
      end,
    },
    {
      "lewis6991/hover.nvim",
      lazy = false,
      opts = {
        init = function() require "hover.providers.lsp" end,
        preview_window = true,
        title = false,
      },
    },
    {
      "nvim-neotest/neotest",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "haydenmeade/neotest-jest",
        "rouge8/neotest-rust",
      },
      opts = function()
        return {
          adapters = {
            require "neotest-rust",
            require "neotest-jest" {
              jestCommand = "pnpm jest",
              jestConfigFile = "jest.config.js",
              env = { CI = true },
              cwd = function() return vim.fn.getcwd() end,
            },
          },
        }
      end,
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      lazy = false,
      requires = { "mfussenegger/nvim-dap", "microsoft/vscode-js-debug" },
      opts = {
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      },
    },
    {
      "folke/neodev.nvim",
      lazy = false,
    },
    {
      "wakatime/vim-wakatime",
      lazy = false,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      lazy = false,
      opts = {
        ensure_installed = { "rust_analyzer" },
      },
    },
    {
      "ggandor/leap.nvim",
      lazy = false,
      dependencies = {
        "tpope/vim-repeat",
      },
      config = function() require("leap").add_default_mappings() end,
    },
    {
      "akinsho/toggleterm.nvim",
      opts = {
        on_open = function() vim.cmd "startinsert" end
      }
    },
  },
  mappings = {
    n = {
      -- make copy-pasting use the system clipboard by default
      p = { '"+p' },
      P = { '"+P' },
      ["<C-s>"] = { ":w<cr>", desc = "Save File" },
      ["<C-V>"] = { "p", desc = "Paste" },
      ["<leader>C"] = { name = "Crates" },
      ["<leader>T"] = { name = "Tests" },
      ["<leader>r"] = { name = "Search and replace" },
      ["<leader>lr"] = { function() require("lspactions").rename() end, desc = "Rename symbol" },
      ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "Code actions" },
      ["<leader>le"] = { function() vim.lsp.buf.definition() end, desc = "Show definition" },
      ["<leader>ln"] = { function() vim.lsp.buf.declaration() end, desc = "Show declaration" },
      ["<leader>lm"] = { function() vim.lsp.buf.implementation() end, desc = "Show implementations" },
      ["<leader>lR"] = { function() vim.lsp.buf.references() end, desc = "Show references" },
      ["<leader>lh"] = { function() require("hover").hover() end, desc = "Hover" },
      ["<leader>lH"] = { function() require("hover").hover_select() end, desc = "Hover (select)" },
      ["<leader>Ct"] = { function() require("crates").toggle() end, desc = "Toggle extra crates.io information" },
      ["<leader>Cr"] = { function() require("crates").reload() end, desc = "Reload information from crates.io" },
      ["<leader>CU"] = { function() require("crates").upgrade_crate() end, desc = "Upgrade a crate" },
      ["<leader>CA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
      ["<leader>Tr"] = { function() require("neotest").run.run() end, desc = "Run closest test" },
      ["<leader>Tf"] = { function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run current file" },
      ["<leader>Td"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug closest test" },
      ["<leader>Tc"] = { function() require("neotest").summary.toggle() end, desc = "Toggle summary window" },
    },
    v = {
      -- Also in visual mode
      x = { '"+x' },
      y = { '"+y' },
      p = { '"_d"+p' },
      P = { '"_d"+P' },
      ["<leader>C"] = { name = "Crates" },
      ["<C-X>"] = { "x", desc = "Cut" },
      ["<C-C>"] = { "y", desc = "Copy" },
      ["<C-V>"] = { '"_d"+P', desc = "Paste" },
      ["<leader>lr"] = { function() require("lspactions").rename() end, desc = "Rename symbol" },
      ["<leader>CU"] = { function() require("crates").upgrade_crates() end, desc = "Upgrade selected crates" },
    },
    t = {
      ["<esc>"] = false,
      ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Exit terminal mode" },
    }
  },
  polish = function()
    require("neodev").setup {
      library = { plugins = { "neotest" }, types = true },
    }

    local dap = require "dap"
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb",
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input {
            prompt = "Path to executable: ",
            default = vim.fn.getcwd() .. "/",
            completion = "file",
          }
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}

return config

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
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end
    },
    config = {
      -- I use rome for formatting
      tsserver = {
        javascript = {
          format = {
            enable = false
          }
        },
        typescript = {
          format = {
            enable = false
          }
        },
      },
    },
  },
  plugins = {
    {
      "catppuccin/nvim",
      as = "catppuccin",
      priority = 1000,
      lazy = false
    },
    {
      "simrat39/rust-tools.nvim",
      after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
      event = "User AstroLspSetup",
      opts  = {
        tools = {
          -- rust-tools options
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
          },
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          standalone = false,
          settings = {
            ['rust-analyzer'] = {
              diagnostics = {
                enable = true,
                -- https://github.com/rust-analyzer/rust-analyzer/issues/6835
                disabled = { 'unresolved-macro-call' },
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
                prefix = 'self',
                granularity = {
                  enforce = true,
                  group = 'crate',
                },
              },
              cargo = {
                loadOutDirsFromCheck = true,
                autoreload = true,
                runBuildScripts = true,
                features = 'all',
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
              hover = {
                actions = {
                  enable = true,
                  run = { enable = true },
                  debug = { enable = true },
                  gotoTypeDef = { enable = true },
                  implementations = { enable = true },
                  references = { enable = true },
                },
                links = { enable = true },
                documentation = { enable = true },
              },
              inlayHints = {
                enable = true,
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = {
                  enable = true,
                  minLines = 10,
                },
                closureReturnTypeHints = { enable = 'always' },
                lifetimeElisionHints = { enable = 'skip_trivial' },
                parameterHints = { enable = false },
                typeHints = { enable = true },
              },
              checkOnSave = {
                enable = true,
                command = 'clippy',
                features = 'all',
              },
            },
          },
        }
      }
    },
    {
      "saecki/crates.nvim",
      event = "BufRead Cargo.toml",
      after = "nvim-cmp",
      config = true,
    },
    {
      "tzachar/cmp-tabnine",
      requires = "nvim-cmp",
      build = "./install.sh",
      config = function()
        local tabnine = require "cmp_tabnine.config"
        tabnine:setup {
          max_lines = 5,
          max_num_results = 4,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = "..",
          ignored_file_types = {},
          show_prediction_strength = false,
        }
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      lazy = false,
      dependencies = {
        "tzachar/cmp-tabnine",
      },
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
          { name = "tabnine",  priority = 700 },
          { name = "crates",   priority = 1100 }
        }
        return opts
      end,
    },
    {
      's1n7ax/nvim-search-and-replace',
      lazy = false,
      opts = {
        ignore = { '**/node_modules/**', '**/.git/**', '**/.gitignore', '**/.gitmodules', 'build/**', 'target/**' },
        update_changes = false,
        replace_keymap = '<leader>rr',
        replace_all_keymap = '<leader>rR',
        replace_and_save_keymap = '<leader>ru',
        replace_all_and_save_keymap = '<leader>rU',
      }
    },
    {
      "RishabhRD/lspactions",
      lazy = false,
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lua/popup.nvim' },
      },
    },
    {
      "lewis6991/hover.nvim",
      lazy = false,
      opts = {
        init = function()
          require("hover.providers.lsp")
        end,
        preview_window = true,
        title = false
      }
    },
    {
      "nvim-neotest/neotest",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "haydenmeade/neotest-jest",
        "rouge8/neotest-rust"
      },
      opts = function()
        return {
          adapters = {
            require("neotest-rust"),
            require("neotest-jest")({
              jestCommand = "pnpm jest",
              jestConfigFile = "jest.config.js",
              env = { CI = true },
              cwd = function()
                return vim.fn.getcwd()
              end,
            }),
          }
        }
      end
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      lazy = false,
      requires = { "mfussenegger/nvim-dap" }
    },
    {
      "microsoft/vscode-js-debug",
      lazy = false,
      build = "pnpm install && pnpm dlx gulp vsDebugServerBundle && mv dist out"
    },
    {
      "folke/neodev.nvim",
      lazy = false
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
         "tpope/vim-repeat"
      },
      config = function()
        require('leap').add_default_mappings()
      end
    }
  },
  mappings = {
    -- make copy-pasting use the system clipboard by default
    n = {
      p = { "\"+p" },
      P = { "\"+P" },
      ["<C-s>"] = { ":w<cr>", desc = "Save File" },
      ["<C-V>"] = { "p", desc = "Paste" },
      ["<leader>C"] = { name = "Crates" },
      ["<leader>T"] = { name = "Tests" },
      ["<leader>r"] = { name = "Search and replace" },
      ["<leader>lr"] = { "<cmd>lua require'lspactions'.rename()<cr>", desc = "Rename symbol" },
      ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code actions" },
      ["<leader>le"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Show definition" },
      ["<leader>ln"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Show declaration" },
      ["<leader>lm"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Show implementations" },
      ["<leader>lR"] = { "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Show references" },
      ["<leader>lh"] = { "<cmd>lua require('hover').hover()<cr>", desc = "Hover" },
      ["<leader>lH"] = { "<cmd>lua require('hover').hover_select()<cr>", desc = "Hover (select)" },
      ["<leader>Ct"] = { "<cmd>lua require('crates').toggle()<cr>", desc = "Toggle extra crates.io information" },
      ["<leader>Cr"] = { "<cmd>lua require('crates').reload()<cr>", desc = "Reload information from crates.io" },
      ["<leader>CU"] = { "<cmd>lua require('crates').upgrade_crate()<cr>", desc = "Upgrade a crate" },
      ["<leader>CA"] = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", desc = "Upgrade all crates" },
      ["<leader>Tr"] = { "<cmd>lua require('neotest').run.run()<cr>", desc = "Run closest test" },
      ["<leader>Tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run current file" },
      ["<leader>Td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug closest test" },
      ["<leader>Tc"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle summary window" },
    },
    v = {
      x = { "\"+x" },
      y = { "\"+y" },
      -- also make pasting in visual mode not overwrite the clipboard
      p = { "\"_d\"+p" },
      P = { "\"_d\"+P" },
      ["<leader>C"] = { name = "Crates" },
      ["<C-X>"] = { "x", desc = "Cut" },
      ["<C-C>"] = { "y", desc = "Copy" },
      ["<C-V>"] = { "p", desc = "Paste" },
      ["<leader>lr"] = { "<cmd>lua require'lspactions'.rename()<cr>", desc = "Rename symbol" },
      ["<leader>CU"] = { "<cmd>lua require('crates').upgrade_crates()<cr>", desc = "Upgrade selected crates" }
    },
  },
  polish = function()
    vim.ui.select = require 'lspactions'.select
    vim.ui.input = require 'lspactions'.input
    vim.lsp.handlers["textDocument/codeAction"] = require 'lspactions'.codeaction
    vim.lsp.handlers["textDocument/references"] = require 'lspactions'.references
    vim.lsp.handlers["textDocument/definition"] = require 'lspactions'.definition
    vim.lsp.handlers["textDocument/declaration"] = require 'lspactions'.declaration
    vim.lsp.handlers["textDocument/implementation"] = require 'lspactions'.implementation

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { "utf-16" }
    require("lspconfig").clangd.setup({ capabilities = capabilities })

    require("neodev").setup({
      library = { plugins = { "neotest" }, types = true },
    })

    local dap = require('dap')
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
      name = 'lldb'
    }
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input({
            prompt = 'Path to executable: ',
            default = vim.fn.getcwd() .. '/',
            completion = 'file'
          })
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    require("dap-vscode-js").setup({
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "pnpm",
            runtimeArgs = {
              "jest",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          }
        }
      }
    end
  end
}

return config

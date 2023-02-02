--              AstroNvim Configuration Table
vim.opt.guifont = { "Iosevka", ":h14" }
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_remember_window_size = true

local config = {
  colorscheme = "catppuccin",
  options = {
    opt = {
      relativenumber = false, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
    },
  },
  lsp = {
    -- skip_setup = { "rust-analyzer" }
  },
  plugins = {
    init = {
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end,
      },
      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          local rt = require("rust-tools")

          rt.setup {
            tools = { -- rust-tools options
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

          rt.runnables.runnables()
        end,
      },
      {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        after = "nvim-cmp",
        config = function()
          require("crates").setup()
          astronvim.add_cmp_source { name = "crates", priority = 1100 }

          -- Crates mappings:
          local map = vim.api.nvim_set_keymap
          map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information" })
          map("n", "<leader>Cr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io" })
          map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate" })
          map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates" })
          map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates" })
        end,
      },
      {
        "tzachar/cmp-tabnine",
        requires = "nvim-cmp",
        run = "./install.sh",
        config = function()
          local tabnine = require "cmp_tabnine.config"
          tabnine:setup {
            max_lines = 5,
            max_num_results = 7,
            sort = true,
            run_on_every_keystroke = true,
            snippet_placeholder = "..",
            ignored_file_types = {},
            show_prediction_strength = false,
          }
          astronvim.add_cmp_source({ name = "cmp_tabnine", priority = 900, max_item_count = 4 })
        end,
      },
      {
        "RishabhRD/lspactions",
        requires = {
          { 'nvim-lua/plenary.nvim' },
          { 'nvim-lua/popup.nvim' },
        },
      },
      {
        "lewis6991/hover.nvim",
        config = function()
          require("hover").setup {
            init = function()
              require("hover.providers.lsp")
            end,
            preview_window = true,
            title = false
          }
        end
      },
      {
        "wakatime/vim-wakatime"
      }
    },
    ["mason-lspconfig"] = {
      ensure_installed = { "rust_analyzer" },
    },
  },
  mappings = {
    -- make copy-pasting use the system clipboard by default
    n = {
      p = { "\"+p" },
      P = { "\"+P" },

      ["<C-s>"] = { ":w<cr>", desc = "Save File" },
      ["<C-V>"] = { "p", desc = "Paste" },

      ["<leader>lr"] = { "<cmd>lua require'lspactions'.rename()<cr>", desc = "Rename symbol" },
      ["<leader>la"] = { "<cmd>lua require'lspactions'.code_action()<cr>", desc = "Rename symbol" },
      ["<leader>le"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Show definition" },
      ["<leader>ld"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Show declaration" },
      ["<leader>lm"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Show implementations" },

      ["<leader>lh"] = { "<cmd>lua require('hover').hover()<cr>", desc = "Hover" },
      ["<leader>lH"] = { "<cmd>lua require('hover').hover_select()<cr>", desc = "Hover (select)" },
    },
    v = {
      x = { "\"+x" },
      y = { "\"+y" },
      -- also make pasting in visual mode not overwrite the clipboard
      p = { "\"_d\"+p" },
      P = { "\"_d\"+P" },

      ["<C-X>"] = { "x", desc = "Cut" },
      ["<C-C>"] = { "y", desc = "Copy" },
      ["<C-V>"] = { "p", desc = "Paste" },

      ["<leader>lr"] = { "<cmd>lua require'lspactions'.rename()<cr>", desc = "Rename symbol" },
    },
    i = {
      -- saving also in insert mode
      ["<C-S>"] = { "<cmd>w<cr>", desc = "Save File" },

      ["<F2>"] = { "<cmd>lua require'lspactions'.rename()<cr>", desc = "Rename symbol" },
    },
  },
  ["which-key"] = {
    register = {
      n = {
        ["<leader>"] = {
          ["C"] = { name = "Crates" },
        },
      },
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
  end
}

return config

return {
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
    "David-Kunz/cmp-npm",
    event = "BufRead package.json",
    after = "nvim-cmp",
    opts = { ignore = { "beta", "rc" } },
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
        { name = "npm",      priority = 1100 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }
      opts.mapping = cmp.mapping.preset.insert {
        ["<CR>"] = cmp.mapping {
          i = function(fallback)
            if cmp.visible() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm { select = true },
          c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        },
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
      on_open = function() vim.cmd "startinsert" end,
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astronvim.utils.status"

      -- VSCode style winbar
      opts.winbar = {
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        fallthrough = false,
        {
          condition = function() return not status.condition.is_active() end,
          status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
          status.component.file_info {
            file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          },
        },
        {
          status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
          status.component.file_info {
            file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbar", true),
            surround = false,
            update = "BufEnter",
          },
          status.component.breadcrumbs {
            icon = { hl = true },
            hl = status.hl.get_attributes("winbar", true),
            prefix = true,
            padding = { left = 0 },
          },
        },
      }

      return opts
    end,
  },
}

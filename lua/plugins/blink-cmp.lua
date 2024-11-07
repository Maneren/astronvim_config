---@type LazySpec
return {
  "Saghen/blink.cmp",
  event = "BufEnter",
  version = "v0.*",
  dependencies = {
    {
      "Maneren/blink.compat",
      opts = { impersonate_nvim_cmp = true, enable_events = true },
    },
    "rafamadriz/friendly-snippets",
    "kdheepak/cmp-latex-symbols",
    "haskell-snippets.nvim",
  },
  opts = {
    accept = {
      create_undo_point = true,
    },
    keymap = "enter",
    windows = {
      autocomplete = {
        auto_show = true,
        selection = "manual",
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        auto_show = true,
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
    },

    sources = {
      completion = {
        enabled_providers = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "latex",
        },
      },
      providers = {
        latex = {
          name = "latex_symbols",
          module = "blink.compat.source",
          opts = {
            strategy = 0,
          },
        },
      },
    },

    exclude_filetypes = { "TelescopePrompt" },

    highlight = {
      use_nvim_cmp_as_default = true,
    },
  },
  specs = {
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "L3MON4D3/LuaSnip", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}

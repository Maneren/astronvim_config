---@type LazySpec
return {
  "Saghen/blink.cmp",
  event = "BufEnter",
  version = "v0.*",
  dependencies = {
    {
      "saghen/blink.compat",
      dependencies = "Saghen/blink.cmp",
      opts = { impersonate_nvim_cmp = true, enable_events = true },
    },
    "rafamadriz/friendly-snippets",
    "kdheepak/cmp-latex-symbols",
    "haskell-snippets.nvim",
  },
  opts = {
    accept = {
      create_undo_point = true,
      auto_brackets = {
        enabled = true,
        default_brackets = { "(", ")" },
      },
    },
    keymap = "enter",
    windows = {
      autocomplete = {
        auto_show = true,
        max_width = 10,
        selection = "manual",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        auto_show = true,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
      signature_help = {
        auto_show = true,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
      virtual_text = {
        enabled = true,
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
    trigger = { signature_help = { enabled = true } },
    highlight = {
      use_nvim_cmp_as_default = true,
    },
  },
  specs = {
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "nvim-autopairs", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}

---@type LazySpec
return {
  "Saghen/blink.cmp",
  event = "BufEnter",
  version = "v0.*",
  dependencies = {
    {
      "Saghen/blink.compat",
      opts = { impersonate_nvim_cmp = true, enable_events = true },
      dependencies = {
        "kdheepak/cmp-latex-symbols",
      },
    },
    "rafamadriz/friendly-snippets",
    -- TODO: Remove when new version of lazydev is released
    { "folke/lazydev.nvim", branch = "main", tag = nil, commit = nil, version = false },
    "haskell-snippets.nvim",
  },
  ---@type blink.cmp.Config
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
          "lazydev",
        },
      },
      providers = {
        lsp = {
          score_offset = 100,
          -- dont show LuaLS require statements when lazydev has items
          fallback_for = { "lazydev" },
        },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        buffer = {
          score_offset = -10,
        },
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
    { "onsails/lspkind.nvim", enabled = false },
  },
}

---@type LazySpec
return {
  "Saghen/blink.cmp",
  event = "BufEnter",
  build = "cargo build --release --target-dir=target",
  dependencies = {
    {
      "Saghen/blink.compat",
      opts = { impersonate_nvim_cmp = true, enable_events = false },
      dependencies = {
        "kdheepak/cmp-latex-symbols",
      },
    },
    "rafamadriz/friendly-snippets",
    "haskell-snippets.nvim",
    "L3MON4D3/LuaSnip",
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
    },
  },
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
    },

    snippets = {
      expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction) require("luasnip").jump(direction) end,
    },

    completion = {
      list = {
        max_items = 100,
        selection = "auto_insert",
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        direction_priority = { "s", "n" },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
      ghost_text = {
        enabled = false,
      },
    },

    fuzzy = {
      prebuilt_binaries = {
        download = false,
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
          "npm",
          "dadbod",
          "luasnip",
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
        npm = {
          name = "npm",
          module = "blink.compat.source",
          opts = { ignore = { "beta", "rc" }, only_latest_version = true },
        },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        luasnip = {
          name = "luasnip",
          module = "blink.compat.source",

          score_offset = -3,

          opts = {
            use_show_condition = false,
            show_autosnippets = true,
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

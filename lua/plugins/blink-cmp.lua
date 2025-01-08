--- Completion UI
--- https://github.com/Saghen/blink-cmp
--- adapted from astrocommunity

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function get_icon_provider()
  local _, mini_icons = pcall(require, "mini.icons")
  if _G.MiniIcons then
    return function(kind) return mini_icons.get("lsp", kind or "") end
  end
  local lspkind_avail, lspkind = pcall(require, "lspkind")
  if lspkind_avail then
    return function(kind) return lspkind.symbolic(kind, { mode = "symbol" }) end
  end
end
---@type function|false|nil
local icon_provider = false

local function get_icon(ctx)
  ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind
  if ctx.item.source_name == "LSP" then
    local item_doc, color_item = ctx.item.documentation, nil
    if item_doc then
      local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
      color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
    end
    if icon_provider == false then
      icon_provider = get_icon_provider()
    end
    if icon_provider then
      local icon = icon_provider(ctx.kind)
      if icon then
        ctx.kind_icon = icon
      end
    end
    if color_item and color_item.abbr and color_item.abbr_hl_group then
      ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
    end
  end
  return ctx
end

---@type LazySpec
return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "Saghen/blink.compat",
      opts = {},
      dependencies = {
        "kdheepak/cmp-latex-symbols",
      },
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
    },
  },
  ---@type Blink.Config
  opts = {
    keymap = {
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-N>"] = { "select_next", "show" },
      ["<C-P>"] = { "select_prev", "show" },
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" },
      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      menu = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                get_icon(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx) return get_icon(ctx).kind_hl_group end,
            },
          },
        },
      },
      list = {
        selection = function(ctx) return ctx.mode == "cmdline" and "auto_insert" or "manual" end,
      },
      accept = {
        auto_brackets = {
          enabled = true,
          override_brackets_for_filetypes = {
            robot = { "   " },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
    },
    signature = {
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    sources = {
      min_keyword_length = function(ctx)
        if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
          return 2
        end
        return 0
      end,
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "latex",
      },
      per_filetype = {
        sql = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "dadbod",
        },
        lua = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "latex",
          "lazydev",
        },
        json = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "latex",
          "npm",
        },
      },
      providers = {
        lsp = {
          score_offset = 100,
        },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" }, score_offset = 100 },
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
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrolsp",
      optional = true,
      opts = function(_, opts) opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities) end,
    },
    { "catppuccin", opts = { integrations = { blink_cmp = true } } },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "petertriho/cmp-git", enabled = false },
    { "L3MON4D3/LuaSnip", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}

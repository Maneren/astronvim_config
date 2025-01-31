--- Completion UI
--- https://github.com/Saghen/blink-cmp
--- extends astrocommunity

---@type LazySpec
return {
  "Saghen/blink.cmp",
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
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "typr" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    completion = {
      menu = { auto_show = true },
      list = { selection = { preselect = false, auto_insert = true } },
      accept = {
        auto_brackets = {
          override_brackets_for_filetypes = {
            robot = { "   " },
          },
        },
      },
    },
    sources = {
      min_keyword_length = function(ctx)
        if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
          return 2
        end
        return 0
      end,
      default = function(_)
        local success, node = pcall(vim.treesitter.get_node)
        if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
          return { "buffer" }
        end

        local base = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "latex",
        }

        local additional = {
          lua = { "lazydev" },
          sql = { "dadbod" },
        }

        local ft = vim.bo.filetype

        if additional[ft] then
          for _, provider in ipairs(additional[ft]) do
            table.insert(base, provider)
          end
        end

        return base
      end,
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
    { "catppuccin", opts = { integrations = { blink_cmp = true } } },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "petertriho/cmp-git", enabled = false },
  },
}

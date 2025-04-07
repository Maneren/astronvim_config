--- Completion UI
--- https://github.com/Saghen/blink-cmp
--- extends astrocommunity

-- https://github.com/Saghen/blink.cmp/pull/1354
local function inside_comment_block()
  if vim.api.nvim_get_mode().mode ~= "i" then
    return false
  end

  local ok, node_under_cursor = pcall(vim.treesitter.get_node)

  if not ok or not node_under_cursor then
    return false
  end

  local parser = vim.treesitter.get_parser(nil, nil, { error = false })

  if not parser then
    return false
  end

  local query = vim.treesitter.query.get(parser:lang(), "highlights")

  if not query then
    return false
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  for id, node, _ in query:iter_captures(node_under_cursor, 0, row, row + 1) do
    if query.captures[id]:find("comment") then
      local start_row, start_col, end_row, end_col = node:range()
      if start_row <= row and row <= end_row then
        if start_row == row and end_row == row then
          if start_col <= col and col <= end_col then
            return true
          end
        elseif start_row == row then
          if start_col <= col then
            return true
          end
        elseif end_row == row then
          if col <= end_col then
            return true
          end
        else
          return true
        end
      end
    end
  end
  return false
end

---@type LazySpec
return {
  "Saghen/blink.cmp",
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
    {
      "Kaiser-Yang/blink-cmp-git",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    "mikavilpas/blink-ripgrep.nvim",
  },
  ---@type blink.cmp.Config
  opts = {
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
      keyword = {
        range = "full",
      },
    },
    fuzzy = {
      sorts = {
        -- always place exact matches first
        "exact",
        "score",
        "sort_text",
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
        if inside_comment_block() then
          return { "path", "buffer", "latex", "git", "ripgrep" }
        end

        local base = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "latex",
          "git",
          "ripgrep",
        }

        local additional = {
          lua = { "lazydev" },
          sql = { "dadbod" },
        }

        local ft = vim.bo.filetype

        if ft and additional[ft] then
          vim.list_extend(base, additional[ft])
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
        git = {
          module = "blink-cmp-git",
          name = "Git",
          score_offset = -50,
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          score_offset = -20,
        },
      },
    },
  },
  specs = {
    { "catppuccin", opts = { integrations = { blink_cmp = true } } },
  },
}

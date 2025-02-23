--- Bundle of useful snippets
--- https://github.com/folke/snacks.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    local rainbow_highlights = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }
    local buf_utils = require("astrocore.buffer")
    return require("astrocore").extend_tbl(opts, {
      indent = {
        indent = {
          char = "▎",
        },
        animate = {
          style = "out",
          easing = "inOutQuad",
          duration = {
            step = 10,
            total = 100,
          },
        },
        scope = {
          enabled = true,
          char = "▎",
          underline = true,
          hl = rainbow_highlights,
        },
        filter = function(bufnr)
          return buf_utils.is_valid(bufnr)
            and not buf_utils.is_large(bufnr)
            and vim.g.snacks_indent ~= false
            and vim.b[bufnr].snacks_indent ~= false
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<a-s>"] = { "flash", mode = { "n", "i" } },
              ["s"] = { "flash" },
            },
          },
        },
        actions = {
          flash = function(picker)
            require("flash").jump {
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            }
          end,
        },
      },
      notifier = {
        timeout = 3000,
        icons = {
          DEBUG = get_icon("Debugger"),
          ERROR = get_icon("DiagnosticError"),
          INFO = get_icon("DiagnosticInfo"),
          TRACE = get_icon("DiagnosticHint"),
          WARN = get_icon("DiagnosticWarn"),
        },
      },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
      words = { enabled = true },
      zen = {},
    })
  end,
  specs = {
    { "catppuccin", opts = { integrations = { snacks = true } } },
    { "rcarriga/nvim-notify", enabled = false },
    { "RRethy/vim-illuminate", enabled = false },
    { "lukas-reineke/indent-blankline.nvim", enabled = false },
    {
      "astrocore",
      ---@param _ LazyPlugin
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = opts.mappings or {}
        maps.n = maps.n or {}

        maps.n["<Leader>u|"] = {
          function()
            vim.g.snacks_indent = vim.g.snacks_indent == false
            vim.cmd([[redraw!]])
          end,
          desc = "Toggle indent guides",
        }

        maps.n["<Leader><Leader>"] = { function() require("snacks").picker.smart() end, desc = "Smart Open" }

        maps.n["<Leader>fu"] = { function() require("snacks").picker.undo() end, desc = "Find undo" }
        maps.n["<Leader>fe"] = { function() require("snacks").picker.explorer() end, desc = "Toggle Finder" }

        maps.n["grr"] = {
          function() require("snacks").picker.lsp_references() end,
          nowait = true,
          desc = "Search references",
        }
        maps.n["<Leader>rR"] = maps.n["grr"]

        maps.n["gd"] = { function() require("snacks").picker.lsp_definitions() end, desc = "Goto Definition" }
        maps.n["gI"] = { function() require("snacks").picker.lsp_implementations() end, desc = "Goto Implementation" }
        maps.n["gy"] =
          { function() require("snacks").picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" }

        maps.n["<Leader>lG"] = {
          function() require("snacks").picker.lsp_workspace_symbols() end,
          nowait = true,
          desc = "Search workspace symbols",
        }

        maps.n["<Leader>uD"] = {
          function() require("snacks.notifier").hide() end,
          desc = "Dismiss notifications",
        }

        maps.n["]r"] = { function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" }
        maps.n["[r"] = { function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference" }

        opts.mappings = maps
      end,
    },
  },
}

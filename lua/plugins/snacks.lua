--- Bundle of useful snippets
--- https://github.com/folke/snacks.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    return require("astrocore").extend_tbl(opts, {
      dashboard = {
        preset = {
          keys = {
            { key = "n", action = "<Leader>n", icon = get_icon("FileNew", 0, true), desc = "New File  " },
            { key = "f", action = "<Leader>ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
            { key = "o", action = "<Leader>fo", icon = get_icon("DefaultFile", 0, true), desc = "Recents  " },
            { key = "w", action = "<Leader>fw", icon = get_icon("WordFile", 0, true), desc = "Find Word  " },
            { key = "'", action = "<Leader>f'", icon = get_icon("Bookmarks", 0, true), desc = "Bookmarks  " },
            { key = "s", action = "<Leader>SF", icon = get_icon("Refresh", 0, true), desc = "Sessions  " },
            { key = "q", action = "<Leader>Q", icon = get_icon("Exit", 0, true), desc = "Quit  " },
          },
        },
      },
      indent = {
        indent = {
          char = "▏",
        },
        animate = {
          enabled = true,
          style = "out",
          easing = "inOutQuad",
          duration = {
            step = 10,
            total = 100,
          },
        },
        scope = {
          char = "▏",
          underline = true,
          hl = vim.tbl_get(vim.g, "rainbow_delimiters", "highlight") or {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        },
      },
      input = {},
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
      },
      quickfile = {},
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
      words = { enabled = true },
    })
  end,
  specs = {
    { "catppuccin", opts = { integrations = { snacks = true } } },
    { "RRethy/vim-illuminate", enabled = false },
    {
      "astrocore",
      ---@param _ LazyPlugin
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = opts.mappings or {}
        maps.n = maps.n or {}

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

        maps.n["]r"] = { function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" }
        maps.n["[r"] = { function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference" }

        opts.mappings = maps
      end,
    },
    {
      "astroui",
      opts = {
        icons = {
          Exit = "󰈆",
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...) require("snacks").debug.inspect(...) end
        _G.bt = function() require("snacks").debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}

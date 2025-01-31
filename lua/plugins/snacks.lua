--- Bundle of useful snippets
--- https://github.com/folke/snacks.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  opts = {
    picker = {
      layout = {
        preset = "telescope",
      },
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
    notifier = {},
  },
  specs = {
    { "catppuccin", opts = { integrations = { snacks = true } } },
    {
      "astrocore",
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

        opts.mappings = maps
      end,
    },
  },
}

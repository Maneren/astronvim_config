--- Modern search and replace
--- https://github.com/MagicDuck/grug-far.nvim

---@type LazySpec
return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    keys = { "<Leader>s" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<Leader>s"] = { group = "󰛔 Search / Replace" },
              ["<Leader>ss"] = {
                function() require("grug-far").grug_far() end,
                desc = "󰛔 Search / Replace",
              },
              ["<Leader>sS"] = {
                function() require("grug-far").grug_far { flags = vim.fn.expand("%") } end,
                desc = "󰛔 Search / Replace (current file)",
              },
            },
            x = {
              ["<Leader>s"] = { group = "󰛔 Search / Replace" },
              ["<Leader>ss"] = {
                function() require("grug-far").with_visual_selection { prefills = { flags = vim.fn.expand("%") } } end,
                desc = "󰛔 Search / Replace (current selection)",
              },
              ["<Leader>sS"] = {
                function()
                  require("grug-far").with_visual_selection {
                    prefills = { flags = vim.fn.expand("%"), path = vim.fn.expand("%") },
                  }
                end,
                desc = "󰛔 Search / Replace (current selection and file)",
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      commands = {
        grug_far = function(state)
          local grugFar = require("grug-far")

          local node = state.tree:get_node()

          -- escape all spaces in the path with "\ "
          local path = node:get_id():gsub(" ", "\\ ")

          local prefills = {
            paths = path,
          }

          if not grugFar.has_instance("tree") then
            grugFar.grug_far {
              instanceName = "tree",
              prefills = prefills,
              staticTitle = "Find and Replace from Tree",
            }
          else
            grugFar.open_instance("tree")
            grugFar.update_instance_prefills("tree", prefills, false)
          end
        end,
      },
    },
  },
}

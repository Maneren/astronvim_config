--- Modern search and replace
--- https://github.com/MagicDuck/grug-far.nvim

---@type AstroCoreMappings
local mappings = {
  ["<Leader>s"] = { group = "󰛔 Search / Replace" },
  ["<Leader>ss"] = {
    function() require("grug-far").open() end,
    desc = "󰛔 Search / Replace",
  },
  ["<Leader>sS"] = {
    function() require("grug-far").open { paths = vim.fn.expand("%"):gsub(" ", "\\ ") } end,
    desc = "󰛔 Search / Replace (current file)",
  },
}

---@type LazySpec
return {
  {
    "MagicDuck/grug-far.nvim",
    ---@type GrugFarOptions
    opts = {
      engines = {
        astgrep = {
          path = "ast-grep",
        },
      },
    },
    keys = { "<Leader>s" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = mappings,
            x = mappings,
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
            grugFar.open {
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

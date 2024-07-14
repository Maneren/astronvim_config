--- Modern search and replace
--- https://github.com/MagicDuck/grug-far.nvim

---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  config = true,
  event = "VeryLazy",
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { GrugFar = "󰛔" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<Leader>s"] = { desc = require("astroui").get_icon("GrugFar", 1, true) .. "Search / Replace" }
        maps.n["<Leader>sg"] = { function() require("grug-far").grug_far() end, desc = "Grug Find and Replace" }
      end,
    },
  },
}

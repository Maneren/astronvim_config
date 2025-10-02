--- File manager
--- https://github.com/A7Lavinraj/fyler.nvim

--- @type LazySpec
return {
  "A7Lavinraj/fyler.nvim",
  event = "VeryLazy",
  cmd = { "Fyler" },
  dependencies = { "echasnovski/mini.icons" },
  version = "*",
  opts = {},
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        maps.n["<Leader>E"] = { function() require("fyler").toggle { kind = "split_left_most" } end, desc = "Fyler" }
      end,
    },
  },
}

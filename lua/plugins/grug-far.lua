--- Modern search and replace
--- https://github.com/MagicDuck/grug-far.nvim

---@type LazySpec
return {
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
            ["<Leader>s"] = {
              function() require("grug-far").grug_far() end,
              desc = "󰛔 Search / Replace",
            },
          },
          x = {
            ["<Leader>s"] = {
              function() require("grug-far").with_visual_selection() end,
              desc = "󰛔 Search / Replace (current selection)",
            },
          },
        },
      },
    },
  },
}

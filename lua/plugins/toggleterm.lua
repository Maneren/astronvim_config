---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  dependencies = {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>tt"] = {
            function() require("toggleterm").toggle(nil, nil, "tab") end,
            desc = "ToggleTerm tab",
          },
        },
      },
    },
  },
}

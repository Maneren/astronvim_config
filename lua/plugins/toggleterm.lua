---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  opts = {
    start_in_insert = true,
  },
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
          ["<Leader>tb"] = {
            function() require("astrocore").toggle_term_cmd("btop") end,
            desc = "ToggleTerm btop",
          },
          ["<Leader>tp"] = {
            function() require("astrocore").toggle_term_cmd("ipython") end,
            desc = "ToggleTerm ipython",
          },
          ["<Leader>tu"] = {
            function() require("astrocore").toggle_term_cmd("dua i") end,
            desc = "ToggleTerm Dua",
          },
        },
      },
    },
  },
}

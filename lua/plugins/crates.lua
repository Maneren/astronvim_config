---@type LazySpec
return {
  {
    "saecki/crates.nvim",
    keys = {
      {
        "<Leader>rt",
        function() require("crates").toggle() end,
        desc = "Toggle extra crates.io information",
        mode = "n",
      },
      {
        "<Leader>rr",
        function() require("crates").reload() end,
        desc = "Reload information from crates.io",
        mode = "n",
      },
      { "<Leader>rU", function() require("crates").upgrade_crate() end, desc = "Upgrade a crate", mode = "n" },
      { "<Leader>rA", function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates", mode = "n" },

      { "<Leader>rU", function() require("crates").upgrade_crates() end, desc = "Upgrade selected crates", mode = "v" },
    },
  },
  {
    "astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>r"] = { name = " Crates" },
        },
      },
    },
  },
}

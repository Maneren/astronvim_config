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
      {
        "<Leader>rv",
        function() require("crates").show_versions_popup() end,
        desc = "Show versions popup",
        mode = "n",
      },
      {
        "<Leader>rf",
        function() require("crates").show_features_popup() end,
        desc = "Show features popup",
        mode = "n",
      },
      {
        "<Leader>rd",
        function() require("crates").show_dependencies_popup() end,
        desc = "Show dependencies popup",
        mode = "n",
      },
      { "<Leader>ru", function() require("crates").update_crate() end, desc = "Update a crate", mode = "n" },
      { "<Leader>ru", function() require("crates").update_crates() end, desc = "Update selected crates", mode = "v" },
      { "<Leader>ra", function() require("crates").update_all_crates() end, desc = "Update all crates", mode = "n" },
      { "<Leader>rU", function() require("crates").upgrade_crate() end, desc = "Upgrade a crate", mode = "n" },
      { "<Leader>rU", function() require("crates").upgrade_crates() end, desc = "Upgrade selected crates", mode = "v" },
      { "<Leader>rA", function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates", mode = "n" },

      {
        "<Leader>rx",
        function() require("crates").expand_plain_crate_to_inline_table() end,
        desc = "Expand crate to table",
        mode = "n",
      },
      {
        "<Leader>rX",
        function() require("crates").extract_crate_into_table() end,
        desc = "Extract crate to table",
        mode = "n",
      },

      { "<Leader>rH", function() require("crates").open_homepage() end, desc = "Open homepage", mode = "n" },
      { "<Leader>rR", function() require("crates").open_repository() end, desc = "Open repository", mode = "n" },
      { "<Leader>rD", function() require("crates").open_documentation() end, desc = "Open documentation", mode = "n" },
      { "<Leader>rC", function() require("crates").open_crates_io() end, desc = "Open crates.io", mode = "n" },
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

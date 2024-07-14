local prefix = "<Leader>R"
---@type LazySpec
return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
  },
  {
    "astrocore",
    opts = {
      mappings = {
        n = {
          [prefix] = { group = " Crates" },
          [prefix .. "t"] = {
            function() require("crates").toggle() end,
            desc = "Toggle extra crates.io information",
          },
          [prefix .. "r"] = {
            function() require("crates").reload() end,
            desc = "Reload information from crates.io",
          },
          [prefix .. "v"] = {
            function() require("crates").show_versions_popup() end,
            desc = "Show versions popup",
          },
          [prefix .. "f"] = {
            function() require("crates").show_features_popup() end,
            desc = "Show features popup",
          },
          [prefix .. "d"] = {
            function() require("crates").show_dependencies_popup() end,
            desc = "Show dependencies popup",
          },
          [prefix .. "u"] = {
            function() require("crates").update_crate() end,
            desc = "Update a crate",
          },
          [prefix .. "a"] = {
            function() require("crates").update_all_crates() end,
            desc = "Update all crates",
          },
          [prefix .. "U"] = {
            function() require("crates").upgrade_crate() end,
            desc = "Upgrade a crate",
          },
          [prefix .. "A"] = {
            function() require("crates").upgrade_all_crates() end,
            desc = "Upgrade all crates",
          },
          [prefix .. "x"] = {
            function() require("crates").expand_plain_crate_to_inline_table() end,
            desc = "Expand crate to table",
          },
          [prefix .. "X"] = {
            function() require("crates").extract_crate_into_table() end,
            desc = "Extract crate to table",
          },
          [prefix .. "H"] = {
            function() require("crates").open_homepage() end,
            desc = "Open homepage",
          },
          [prefix .. "R"] = {
            function() require("crates").open_repository() end,
            desc = "Open repository",
          },
          [prefix .. "D"] = {
            function() require("crates").open_documentation() end,
            desc = "Open documentation",
          },
          [prefix .. "C"] = {
            function() require("crates").open_crates_io() end,
            desc = "Open crates.io",
          },
        },
        x = {
          [prefix .. "u"] = {
            function() require("crates").update_crates() end,
            desc = "Update selected crates",
          },
          [prefix .. "U"] = {
            function() require("crates").upgrade_crates() end,
            desc = "Upgrade selected crates",
          },
        },
      },
    },
  },
}

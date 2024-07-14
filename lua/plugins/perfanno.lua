---@type LazySpec
return {
  "t-troebst/perfanno.nvim",
  opts = {},
  dependencies = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>P"] = { group = "PerfAnno" },
            ["<Leader>Pl"] = { group = "Load perf profile" },
            ["<Leader>Plf"] = {
              ":PerfLoadFlat<CR>",
              desc = "Flat profile",
            },
            ["<Leader>Plg"] = {
              ":PerfLoadCallGraph<CR>",
              desc = "Call graph profile",
            },
            ["<Leader>Plo"] = {
              ":PerfLoadFlameGraph<CR>",
              desc = "Flame graph profile",
            },
            ["<Leader>Pe"] = {
              ":PerfPickEvent<CR>",
              desc = "Pick an event for profiling",
            },
            ["<Leader>Pa"] = {
              ":PerfAnnotate<CR>",
              desc = "Annotate performance data",
            },
            ["<Leader>Pf"] = {
              ":PerfAnnotateFunction<CR>",
              desc = "Annotate performance data for a specific function",
            },
            ["<Leader>Pt"] = {
              ":PerfToggleAnnotations<CR>",
              desc = "Toggle performance annotations",
            },
            ["<Leader>Ph"] = {
              ":PerfHottestLines<CR>",
              desc = "Show hottest lines",
            },
            ["<Leader>Ps"] = {
              ":PerfHottestSymbols<CR>",
              desc = "Show hottest symbols",
            },
            ["<Leader>Pc"] = {
              ":PerfHottestCallersFunction<CR>",
              desc = "Show hottest callers of a function",
            },
          },
          v = {
            ["<Leader>P"] = { group = "PerfAnno" },
            ["<Leader>Pa"] = {
              ":PerfAnnotateSelection<CR>",
              desc = "Annotate performance data for selected code",
            },
            ["<Leader>Pc"] = {
              ":PerfHottestCallersSelection<CR>",
              desc = "Show hottest callers for selected code in performance profile",
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("perfanno").setup(opts)

    local telescope = require("telescope")
    local actions = telescope.extensions.perfanno.actions
    telescope.setup {
      extensions = {
        perfanno = {
          mappings = {
            ["i"] = {
              ["<C-h>"] = actions.hottest_callers,
              ["<C-l>"] = actions.hottest_callees,
            },
            ["n"] = {
              ["gu"] = actions.hottest_callers,
              ["gd"] = actions.hottest_callees,
            },
          },
        },
      },
    }
  end,
  commands = {
    "PerfLoadFlat",
    "PerfLoadCallGraph",
    "PerfLoadFlameGraph",
    "PerfPickEvent",
    "PerfAnnotate",
    "PerfAnnotateFunction",
    "PerfToggleAnnotations",
    "PerfHottestLines",
    "PerfHottestSymbols",
    "PerfHottestCallersFunction",
    "PerfAnnotateSelection",
    "PerfHottestCallersSelection",
  },
}

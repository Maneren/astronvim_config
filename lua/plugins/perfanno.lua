--- Performance profiling annotations
--- https://github.com/t-troebst/perfanno.nvim

---@type LazySpec
return {
  "t-troebst/perfanno.nvim",
  cmd = {
    "PerfLoadFlat",
    "PerfLoadCallGraph",
    "PerfLoadFlameGraph",
    "PerfPickEvent",
    "PerfAnnotate",
    "PerfAnnotateFunction",
    "PerfAnnotateSelection",
    "PerfHottestCallersFunction",
    "PerfHottestCallersSelection",
  },
  dependencies = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>P"] = { group = "󱫐 PerfAnno" },
            ["<Leader>Pl"] = { group = "Load perf profile" },
            ["<Leader>Plf"] = {
              "<Cmd>PerfLoadFlat<CR>",
              desc = "Flat profile",
            },
            ["<Leader>Plg"] = {
              "<Cmd>PerfLoadCallGraph<CR>",
              desc = "Call graph profile",
            },
            ["<Leader>Plo"] = {
              "<Cmd>PerfLoadFlameGraph<CR>",
              desc = "Flame graph profile",
            },
            ["<Leader>Pe"] = {
              "<Cmd>PerfPickEvent<CR>",
              desc = "Pick an event for profiling",
            },
            ["<Leader>Pa"] = {
              "<Cmd>PerfAnnotate<CR>",
              desc = "Annotate performance data",
            },
            ["<Leader>Pf"] = {
              "<Cmd>PerfAnnotateFunction<CR>",
              desc = "Annotate performance data for a specific function",
            },
            ["<Leader>Pt"] = {
              "<Cmd>PerfToggleAnnotations<CR>",
              desc = "Toggle performance annotations",
            },
            ["<Leader>Ph"] = {
              "<Cmd>PerfHottestLines<CR>",
              desc = "Show hottest lines",
            },
            ["<Leader>Ps"] = {
              "<Cmd>PerfHottestSymbols<CR>",
              desc = "Show hottest symbols",
            },
            ["<Leader>Pc"] = {
              "<Cmd>PerfHottestCallersFunction<CR>",
              desc = "Show hottest callers of a function",
            },
          },
          v = {
            ["<Leader>P"] = { group = "PerfAnno" },
            ["<Leader>Pa"] = {
              "<Cmd>PerfAnnotateSelection<CR>",
              desc = "Annotate performance data for selected code",
            },
            ["<Leader>Pc"] = {
              "<Cmd>PerfHottestCallersSelection<CR>",
              desc = "Show hottest callers for selected code in performance profile",
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    opts.line_highlights = require("perfanno.util").make_bg_highlights("#1B1B28", "#d0164a", 10)
    opts.vt_highlight = require("perfanno.util").make_fg_highlight("#d0164a")

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
}

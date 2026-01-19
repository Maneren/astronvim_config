return {
  "esmuellert/codediff.nvim",
  opts = {
    highlights = {
      line_insert = "DiffAdd",
      line_delete = "DiffDelete",
    },

    diff = {
      disable_inlay_hints = true,
      max_computation_time_ms = 5000,
    },
  },
}

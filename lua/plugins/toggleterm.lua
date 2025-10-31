--- Toggleable terminal
--- https://github.com/akinsho/toggleterm.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  opts = {
    start_in_insert = true,
    direction = "vertical",
    auto_scroll = true,
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.2
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  },
  specs = {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>tb"] = {
            function() require("astrocore").toggle_term_cmd { cmd = "btop", direction = "float" } end,
            desc = "ToggleTerm btop",
          },
          ["<Leader>tp"] = {
            function() require("astrocore").toggle_term_cmd { cmd = "ipython", direction = "float" } end,
            desc = "ToggleTerm ipython",
          },
          ["<Leader>ts"] = {
            function() require("astrocore").toggle_term_cmd { cmd = "lazysql", direction = "float" } end,
            desc = "ToggleTerm lazysql",
          },
          ["<Leader>tu"] = {
            function() require("astrocore").toggle_term_cmd { cmd = "dua i", direction = "float" } end,
            desc = "ToggleTerm Dua",
          },
        },
      },
    },
  },
}

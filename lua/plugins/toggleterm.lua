---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  opts = {
    start_in_insert = true,
    on_open = function() vim.cmd("startinsert!") end,
    direction = "vertical",
  },
  dependencies = {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>tt"] = {
            "<Cmd>ToggleTerm direction=tab<CR>",
            desc = "ToggleTerm tab",
          },
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

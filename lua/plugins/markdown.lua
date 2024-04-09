---@type LazySpec
return {
  {
    "ixru/nvim-markdown",
    ft = { "markdown" },
  },
  {
    "allen-mack/nvim-table-md",
    ft = { "markdown" },
    keys = {
      { "<Leader>mf", function() require("tablemd").format() end, desc = "Format table" },
      { "<Leader>mc", function() require("tablemd").insertColumn(false) end, desc = "Insert column" },
      { "<Leader>md", function() require("tablemd").deleteColumn() end, desc = "Delete column" },
      { "<Leader>mr", function() require("tablemd").insertRow(false) end, desc = "Insert row above" },
      { "<Leader>mR", function() require("tablemd").insertRow(true) end, desc = "Insert row below" },
      { "<Leader>mj", function() require("tablemd").alignColumn("left") end, desc = "Align column left" },
      { "<Leader>mk", function() require("tablemd").alignColumn("center") end, desc = "Align column center" },
      { "<Leader>ml", function() require("tablemd").alignColumn("right") end, desc = "Align column right" },
    },
  },
  {
    "toppair/peek.nvim",
    ft = { "markdown" },
    opts = { app = "firefox" },
    keys = {
      { "<Leader>mP", function() require("peek").open() end, desc = "Open preview window" },
      { "<Leader>mp", function() require("peek").close() end, desc = "Close preview window" },
    },
  },
  {
    "astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>m"] = { name = "󰈙 Markdown" },
        },
      },
      options = {
        g = {
          vim_markdown_math = 1,
          vim_markdown_conceal = 0,
        },
      },
    },
  },
}

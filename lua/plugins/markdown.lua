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
    "astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>m"] = { name = "󰈙 Markdown" },
          ["<Leader>mp"] = { function() vim.cmd("MarkdownPreview") end, desc = "Open preview" },
          ["<Leader>mP"] = { function() vim.cmd("MarkdownPreviewStop") end, desc = "Close preview" },
        },
      },
      options = {
        g = {
          vim_markdown_math = 1,
          vim_markdown_conceal = 0,

          mkdp_page_title = "${name}",
          mkdp_port = "4333",
        },
      },
    },
  },
}

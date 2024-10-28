---@type LazySpec
return {
  {
    "ixru/nvim-markdown",
    ft = { "markdown" },
  },
  {
    "allen-mack/nvim-table-md",
    ft = { "markdown" },
  },
  { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
  {
    "astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>M"] = { desc = require("astroui").get_icon("Markdown", 1, true) .. "Markdown" },
          ["<Leader>Mp"] = { function() vim.cmd("MarkdownPreview") end, desc = "Open preview" },
          ["<Leader>MP"] = { function() vim.cmd("MarkdownPreviewStop") end, desc = "Close preview" },

          ["<Leader>Mf"] = { function() require("tablemd").format() end, desc = "Format table" },
          ["<Leader>Mc"] = { function() require("tablemd").insertColumn(false) end, desc = "Insert column" },
          ["<Leader>Md"] = { function() require("tablemd").deleteColumn() end, desc = "Delete column" },
          ["<Leader>Mr"] = { function() require("tablemd").insertRow(false) end, desc = "Insert row above" },
          ["<Leader>MR"] = { function() require("tablemd").insertRow(true) end, desc = "Insert row below" },
          ["<Leader>Mj"] = { function() require("tablemd").alignColumn("left") end, desc = "Align column left" },
          ["<Leader>Mk"] = { function() require("tablemd").alignColumn("center") end, desc = "Align column center" },
          ["<Leader>Ml"] = { function() require("tablemd").alignColumn("right") end, desc = "Align column right" },
        },
      },
      options = {
        g = {
          mkdp_page_title = "${name}",
          mkdp_port = "4333",
        },
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "quarto", "rmd" },
    commit = "e2c3e56",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          if opts.ensure_installed ~= "all" then
            opts.ensure_installed = require("astrocore").list_insert_unique(
              opts.ensure_installed,
              { "html", "markdown", "markdown_inline", "latex" }
            )
          end
        end,
      },
    },
    opts = function()
      local presets = require("markview.presets")
      return {
        hybrid_modes = { "n" },
        callbacks = {
          on_enable = function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "c"
          end,
        },
        headings = presets.marker,
        checkboxes = presets.checkboxes.nerd,
        code_blocks = {
          style = "language",
          icons = true,

          hl = "Layer2",

          min_width = 80,
          pad_char = " ",
          pad_amount = 2,

          language_names = {
            { "py", "Python" },
            { "cpp", "C++" },
            { "cs", "C#" },
          },
          name_hl = "Layer2",
          language_direction = "left",
          sign = false,
        },
        inline_codes = {
          hl = "Layer",

          padding_left = "",
          padding_right = "",
        },
        latex = {
          enable = true,
          inline = {
            enable = true,
          },
          operators = {
            enable = true,
          },
          symbols = {
            enable = true,
            overwrite = {
              dots = "…",
              quad = "  ",
              [" "] = " ",
              enspace = " ",
              thinspace = "",
              iff = "⟺ ",
              implies = "⟹ ",
              leftrightarrows = "⇆",
              to = "→",
              forall = "∀",
              emptyset = "∅",
              Chi = "Χ",
              choose = "C",
              coloneqq = "≔",
              E = "E",
              Var = "Var",
            },
          },
        },
      }
    end,
  },
}

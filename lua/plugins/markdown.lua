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
  {
    "astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>m"] = { group = "󰈙 Markdown" },
          ["<Leader>mp"] = { function() vim.cmd("MarkdownPreview") end, desc = "Open preview" },
          ["<Leader>mP"] = { function() vim.cmd("MarkdownPreviewStop") end, desc = "Close preview" },

          ["<Leader>mf"] = { function() require("tablemd").format() end, desc = "Format table" },
          ["<Leader>mc"] = { function() require("tablemd").insertColumn(false) end, desc = "Insert column" },
          ["<Leader>md"] = { function() require("tablemd").deleteColumn() end, desc = "Delete column" },
          ["<Leader>mr"] = { function() require("tablemd").insertRow(false) end, desc = "Insert row above" },
          ["<Leader>mR"] = { function() require("tablemd").insertRow(true) end, desc = "Insert row below" },
          ["<Leader>mj"] = { function() require("tablemd").alignColumn("left") end, desc = "Align column left" },
          ["<Leader>mk"] = { function() require("tablemd").alignColumn("center") end, desc = "Align column center" },
          ["<Leader>ml"] = { function() require("tablemd").alignColumn("right") end, desc = "Align column right" },
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
  {
    "OXY2DEV/markview.nvim",
    ft = function()
      local plugin = require("lazy.core.config").spec.plugins["markview.nvim"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      return opts.filetypes or { "markdown", "quarto", "rmd" }
    end,
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
              iff = "⇔",
              leftrightarrows = "⇆",
              to = "→",
              forall = "∀",
              emptyset = "∅",
            },
          },
        },
      }
    end,
  },
}

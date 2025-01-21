--- Render markdown inside nvim
--- https://github.com/OXY2DEV/markview.nvim
--- adapted from astrocommunity

-- currently pinned to commit, waiting for a complete overhaul of the plugin to
-- finish

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "quarto", "rmd" },
  commit = "e2c3e56",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
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
            thinspace = " ",
            [","] = " ",
            iff = "⟺ ",
            implies = "⟹ ",
            leftrightarrows = "⇆",
            to = "→",
            forall = "∀",
            emptyset = "∅",
            Chi = "Χ",
            choose = "C",
            colon = ":",
            coloneqq = "≔",
            E = "𝔼",
            Var = "Var",
            bit = "bit",
            jinak = "jinak",
          },
        },
      },
    }
  end,
  specs = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "html", "markdown", "markdown_inline", "latex" },
      },
    },
  },
}

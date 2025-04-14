--- Render markdown inside nvim
--- https://github.com/OXY2DEV/markview.nvim
--- adapted from astrocommunity

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  version = "*",
  opts = function()
    local symbols = require("markview.symbols")
    symbols.entries = vim.tbl_extend("force", symbols.entries, {
      ldots = "…",
      quad = "  ",
      [" "] = " ",
      enspace = " ",
      thinspace = " ",
      [","] = " ",
      iff = "⟺ ",
      implies = "⟹ ",
      ge = "≥",
      le = "≤",
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
    })
    local presets = require("markview.presets")
    return {
      preview = {
        ignore_buftypes = { "nofile" },
        debounce = 50,
        icon_provider = "mini",
      },
      markdown = {
        headings = presets.headings.glow,
        tables = presets.tables.rounded,
        code_blocks = {
          style = "language",
          icons = true,

          min_width = 80,
          pad_amount = 2,

          language_names = {
            { "py", "Python" },
            { "cpp", "C++" },
            { "cs", "C#" },
          },
          label_direction = "left",
          sign = false,
        },
      },
      markdown_inline = {
        inline_codes = {
          hl = "Layer",
          padding_left = "",
          padding_right = "",
        },
      },
      latex = {
        blocks = {
          pad_amount = 2,
        },
        inlines = {
          padding_left = "",
          padding_right = "",
          hl = "Layer",
        },
        commands = {
          abs = {
            condition = function(item) return #item.args == 1 end,
            on_command = {
              conceal = "",
            },
            on_args = {
              {
                on_before = function(item)
                  return {
                    end_col = item.range[2] + 1,
                    conceal = "",

                    virt_text_pos = "inline",
                    virt_text = {
                      { "|", "@punctuation.bracket" },
                    },

                    hl_mode = "combine",
                  }
                end,

                after_offset = function(range) return { range[1], range[2], range[3], range[4] - 1 } end,

                on_after = function(item)
                  return {
                    end_col = item.range[4],
                    conceal = "",

                    virt_text_pos = "inline",
                    virt_text = {
                      { "|", "@punctuation.bracket" },
                    },

                    hl_mode = "combine",
                  }
                end,
              },
            },
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

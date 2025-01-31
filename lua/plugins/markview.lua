--- Render markdown inside nvim
--- https://github.com/OXY2DEV/markview.nvim
--- adapted from astrocommunity

--- Creates a configuration table for a LaTeX command.
---@param name string Command name(Text to show).
---@param text_pos? "overlay" | "inline" `virt_text_pos` extmark options.
---@param cmd_conceal? integer Characters to conceal.
---@param cmd_hl? string Highlight group for the command.
---@return commands.opts
local function operator(name, text_pos, cmd_conceal, cmd_hl)
  return {
    condition = function(item) return #item.args == 1 end,

    on_command = function(item)
      return {
        end_col = item.range[2] + (cmd_conceal or 1),
        conceal = "",

        virt_text_pos = text_pos or "overlay",
        virt_text = {
          { name, cmd_hl or "@keyword.function" },
        },

        hl_mode = "combine",
      }
    end,

    on_args = {
      {
        on_before = function(item)
          return {
            end_col = item.range[2] + 1,

            virt_text_pos = "overlay",
            virt_text = {
              { "(", "@punctuation.bracket" },
            },

            hl_mode = "combine",
          }
        end,

        after_offset = function(range) return { range[1], range[2], range[3], range[4] - 1 } end,

        on_after = function(item)
          return {
            end_col = item.range[4],

            virt_text_pos = "overlay",
            virt_text = {
              { ")", "@punctuation.bracket" },
            },

            hl_mode = "combine",
          }
        end,
      },
    },
  }
end

local function symbol(name, text_pos, cmd_conceal, cmd_hl)
  return {
    on_command = function(item)
      return {
        end_col = item.range[2] + (cmd_conceal or 1),
        conceal = "",

        virt_text_pos = text_pos or "overlay",
        virt_text = {
          { name, cmd_hl or "@keyword.function" },
        },

        hl_mode = "combine",
      }
    end,
  }
end

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  version = "*",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = function()
    local presets = require("markview.presets")
    return {
      preview = {
        ignore_buftypes = { "nofile" },
        debounce = 50,
        icon_provider = "devicons",
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
          -- ldots = "…",
          -- quad = operator("  "),
          -- [" "] = " ",
          -- enspace = " ",
          -- thinspace = " ",
          -- [","] = " ",
          -- iff = symbol("⟺ ", "inline", 4),
          -- implies = "⟹ ",
          -- leftrightarrows = "⇆",
          -- to = "→",
          -- forall = "∀",
          -- emptyset = "∅",
          -- Chi = "Χ",
          -- choose = "C",
          -- colon = ":",
          -- coloneqq = "≔",
          -- E = symbol("𝔼"),
          -- Var = operator("Var"),
          -- bit = "bit",
          -- jinak = "jinak",
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

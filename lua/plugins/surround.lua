--- Surround text with pairs
--- https://github.com/kylechui/nvim-surround

---@type LazySpec
return {
  "kylechui/nvim-surround",
  event = "User AstroFile",
  opts = {},
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          i = {
            ["<C-g>z"] = {
              "<Plug>(nvim-surround-insert)",
              desc = "Add a surrounding pair around the cursor (insert mode)",
            },
            ["<C-g>Z"] = {
              "<Plug>(nvim-surround-insert-line)",
              desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
            },
          },
          n = {
            ["gz"] = { "<Plug>(nvim-surround-normal)", desc = "Add a surrounding pair around a motion (normal mode)" },
            ["gZ"] = {
              "<Plug>(nvim-surround-normal-cur)",
              desc = "Add a surrounding pair around the current line (normal mode)",
            },
            ["gzz"] = {
              "<Plug>(nvim-surround-normal-line)",
              desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
            },
            ["gZZ"] = {
              "<Plug>(nvim-surround-normal-cur-line)",
              desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
            },
            ["gzd"] = { "<Plug>(nvim-surround-delete)", desc = "Delete a surrounding pair" },
            ["gzr"] = { "<Plug>(nvim-surround-change)", desc = "Change a surrounding pair" },
          },
          x = {
            ["gz"] = { "<Plug>(nvim-surround-visual)", desc = "Add a surrounding pair around a visual selection" },
            ["gZ"] = {
              "<Plug>(nvim-surround-visual-line)",
              desc = "Add a surrounding pair around a visual selection, on new lines",
            },
          },
        },
      },
    },
  },
}

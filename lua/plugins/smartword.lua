--- Better word-wise navigation
--- https://github.com/anuvyklack/vim-smartword

local mapping = {
  ["w"] = { "<Plug>(smartword-w)", desc = "Smart next word" },
  ["b"] = { "<Plug>(smartword-b)", desc = "Smart prev word" },
  ["e"] = { "<Plug>(smartword-e)", desc = "Smart next end of word" },
  ["ge"] = { "<Plug>(smartword-ge)", desc = "Smart prev end of word" },
}

---@type LazySpec
return {
  "anuvyklack/vim-smartword",
  event = "BufEnter",
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = mapping,
          v = mapping,
          o = mapping,
        },
      },
    },
  },
}

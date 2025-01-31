--- Change text case
--- https://github.com/johmsalas/text-case.nvim

local mappings = {
  ["ga"] = { group = "Text Case" },
}

---@type LazySpec
return {
  "johmsalas/text-case.nvim",
  event = "User AstroFile",
  opts = {},
  specs = {
    {
      "astrocore",
      opts = {
        mappings = {
          n = mappings,
          x = mappings,
        },
      },
    },
  },
}

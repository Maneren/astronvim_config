--- Change text case
--- https://github.com/johmsalas/text-case.nvim

local mappings = {
  ["ga"] = { group = "Text Case" },
  ["ga."] = { function() require("telescope").extensions.textcase.textcase() end, desc = "Telescope" },
}

---@type LazySpec
return {
  "johmsalas/text-case.nvim",
  event = "User AstroFile",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function(_, opts)
    require("textcase").setup(opts)
    require("telescope").load_extension("textcase")
  end,
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

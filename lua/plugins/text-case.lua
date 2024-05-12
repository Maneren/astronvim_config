local mappings = {
  ["ga"] = { name = "Text Case" },
  ["ga."] = { function() require("telescope").extensions.textcase.textcase() end, desc = "Telescope" },
}

--- @type LazySpec
return {
  "johmsalas/text-case.nvim",
  event = "User AstroFile",
  dependencies = {
    "nvim-telescope/telescope.nvim",
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
  config = function()
    require("textcase").setup {}
    require("telescope").load_extension("textcase")
  end,
}

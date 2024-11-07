--- Telescope plugin for smartly finding files
--- https://github.com/danielfalk/smart-open

---@type LazySpec
return {
  "danielfalk/smart-open.nvim",
  branch = "0.3.x",
  config = function() require("telescope").load_extension("smart_open") end,
  dependencies = {
    "kkharji/sqlite.lua",
    { "nvim-telescope/telescope-fzy-native.nvim" },
    {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader><Leader>"] = {
              function() require("telescope").extensions.smart_open.smart_open() end,
              desc = "Smart Open",
            },
          },
        },
      },
    },
  },
}

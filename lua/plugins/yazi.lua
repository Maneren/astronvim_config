--- Yazi file manager for neovim
--- https://github.com/mikavilpas/yazi.nvim

---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  cmd = { "Yazi" },
  ---@type YaziConfig
  opts = {
    open_for_directories = true,
    open_multiple_tabs = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
  dependencies = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>Y"] = { "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
            ["<Leader>y"] = { "<cmd>Yazi toggle<cr>", desc = "Open yazi in nvim's working directory" },
          },
        },
      },
    },
  },
}

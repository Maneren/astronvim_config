--- Yazi file manager integration
--- https://github.com/mikavilpas/yazi.nvim

---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  cmd = { "Yazi" },
  ---@type YaziConfig
  opts = {
    open_multiple_tabs = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
  specs = {
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

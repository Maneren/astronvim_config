--- Yazi file manager integration
--- https://github.com/mikavilpas/yazi.nvim

---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  cmd = { "Yazi" },
  ---@type YaziConfig
  opts = {
    open_multiple_tabs = true,
    future_features = {
      ya_emit_reveal = true,
      ya_emit_open = true,
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

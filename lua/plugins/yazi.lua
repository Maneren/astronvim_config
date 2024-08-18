--- Yazi file manager for neovim
--- https://github.com/mikavilpas/yazi.nvim

---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
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
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        filesystem = {
          hijack_netrw_behavior = "disabled",
        },
      },
    },
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>Y"] = { "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
            ["<Leader>y"] = { "<cmd>Yazi cwd<cr>", desc = "Open yazi in nvim's working directory" },
          },
        },
      },
    },
  },
}

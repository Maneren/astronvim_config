--- Config for neo-tree file explorer
--- https://github.com/nvim-neo-tree/neo-tree.nvim

---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = {
            ".gitignored",
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },
  {
    "mrbjarksen/neo-tree-diagnostics.nvim",
    dependencies = "nvim-neo-tree/neo-tree.nvim",
    module = "neo-tree.sources.diagnostics",
  },
}

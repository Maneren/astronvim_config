--- Config for neo-tree file explorer
--- https://github.com/nvim-neo-tree/neo-tree.nvim

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "mrbjarksen/neo-tree-diagnostics.nvim",
  },
  opts = {
    filesystem = {
      async_directory_scan = "auto",
      scan_mode = "deep",
      group_empty_dirs = true,
      filtered_items = {
        always_show = {
          ".gitignored",
        },
      },
      follow_current_file = {
        enabled = true,
      },
      find_by_full_path_words = true,
    },
    sources = {
      "filesystem",
      "git_status",
      "document_symbols",
      "diagnostics",
    },
    source_selector = {
      sources = {
        { source = "filesystem" },
        { source = "git_status" },
        { source = "diagnostics" },
        { source = "document_symbols" },
      },
    },
    window = {
      width = 40,
    },
  },
}

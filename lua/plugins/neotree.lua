--- Tree-style file explorer
--- https://github.com/nvim-neo-tree/neo-tree.nvim
--- extends AstroNvim

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = nil,
  commit = "4d748ef6953ba0c3a6623dc0a775a5f5989aba70",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      async_directory_scan = "auto",
      scan_mode = "deep",
      group_empty_dirs = true,
      use_libuv_file_watcher = true,
      filtered_items = {
        always_show = {
          ".gitignore",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
          "__pycache__",
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
    },
    window = {
      width = 40,
      mappings = {
        d = "trash",
        D = "delete",
      },
    },
  },
}

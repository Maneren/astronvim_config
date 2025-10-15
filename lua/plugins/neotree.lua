--- Tree-style file explorer
--- https://github.com/nvim-neo-tree/neo-tree.nvim
--- extends AstroNvim

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      filesystem = {
        async_directory_scan = "auto",
        scan_mode = "deep",
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          always_show = {
            ".gitignored",
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
      },
    })
  end,
}

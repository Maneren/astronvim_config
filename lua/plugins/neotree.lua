--- Tree-style file explorer
--- https://github.com/nvim-neo-tree/neo-tree.nvim
--- extends AstroNvim

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "mrbjarksen/neo-tree-diagnostics.nvim",
  },
  cmd = "Neotree",
  opts = function(_, opts)
    local function on_move(data) require("snacks").rename.on_rename_file(data.source, data.destination) end
    local events = require("neo-tree.events")

    return vim.tbl_deep_extend("force", opts, {
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
      window = {
        width = 40,
      },
      event_handlers = {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      },
    })
  end,
}

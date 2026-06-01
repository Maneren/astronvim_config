return {
  "XXiaoA/atone.nvim",
  event = "VeryLazy",
  opts = {
    layout = {
      direction = "left",
      width = 0.25,
    },
    diff_cur_node = {
      enabled = true,
      split_percent = 0.3,
      width = "adaptive",
      treesitter = true,
      inline_diff = true,
    },
    auto_attach = {
      enabled = true,
      excluded_ft = { "oil" },
    },
    marks = {
      persist = true,
      persist_path = vim.fn.stdpath("data") .. "/atone_marks.json",
      finders = { "snacks", "builtin" },
    },
    keymaps = {
      tree = {
        quit = { "<C-c>", "q" },
        next_node = "j", -- support v:count
        pre_node = "k", -- support v:count
        jump_to_G = "G",
        jump_to_gg = "gg",
        undo_to = "<CR>",
        set_mark = "m",
        delete_mark = { "x", "X" },
        delete_all_marks = "dM",
        goto_mark = { "'", "`" },
        mark_picker = "s",
        help = { "?", "g?" },
        float_diff = "gd",
      },
      auto_diff = {
        quit = { "<C-c>", "q" },
        help = { "?", "g?" },
        undo = "u",
        redo = "<C-r>",
        float_diff = "gd",
      },
      help = {
        quit_help = { "<C-c>", "q" },
      },
    },
    diff_float = {
      width = 0.8,
      height = 0.8,
      autoclose = true,
    },
    ui = {
      border = "single",
      compact = true,
    },
  },
}

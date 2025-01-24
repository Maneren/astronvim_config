--- Edgy window layout manager
--- https://github.com/folke/edgy.nvim

---@type LazySpec
return {
  "folke/edgy.nvim",
  enabled = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>F"] = { function() require("edgy").toggle() end, desc = "Toggle Sidebars" },
            ["<Leader>fs"] = { function() require("edgy").select() end, desc = "Pick Sidebar" },
          },
        },
      },
    },
  },
  specs = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        source_selector = {
          winbar = false,
          statusline = false,
          open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
        },
      },
    },
  },
  opts = {
    exit_when_last = true,
    bottom = {
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        filter = function(buf) return vim.bo[buf].buftype == "help" end,
      },
    },
    left = {
      {
        ft = "dbui",
        title = "Databases",
      },
      {
        title = "Files",
        ft = "neo-tree",
        filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
        pinned = true,
        open = "Neotree position=left filesystem",
        size = { height = 0.5 },
      },
      {
        title = "Git Status",
        ft = "neo-tree",
        filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
        pinned = true,
        collapsed = true,
        open = "Neotree position=bottom git_status",
      },
      {
        title = "Dignostics",
        ft = "neo-tree",
        filter = function(buf) return vim.b[buf].neo_tree_source == "diagnostics" end,
        pinned = true,
        collapsed = true,
        open = "Neotree position=right diagnostics",
      },
      {
        title = "Symbols",
        ft = "neo-tree",
        filter = function(buf) return vim.b[buf].neo_tree_source == "document_symbols" end,
        pinned = true,
        collapsed = true,
        open = "Neotree position=top document_symbols",
      },
    },
    right = {
      {
        ft = "toggleterm",
        size = { width = 0.3 },
        -- exclude floating windows and tabs
        filter = function(buf, win)
          local terms = require("toggleterm.terminal")
          local _, term = terms.identify(vim.api.nvim_buf_get_name(buf))
          return vim.api.nvim_win_get_config(win).relative == "" and (term ~= nil and term.direction ~= "tab")
        end,
      },
    },
    keys = {
      ["<C-Right>"] = function(win) win:resize("width", 2) end,
      ["<C-Left>"] = function(win) win:resize("width", -2) end,
      ["<C-Up>"] = function(win) win:resize("height", 2) end,
      ["<C-Down>"] = function(win) win:resize("height", -2) end,
    },
  },
}

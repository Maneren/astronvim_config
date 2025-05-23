---@type LazySpec
local spec = {
  {
    "AstroNvim/AstroNvim",
    version = "5",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      pin_plugins = nil,
    },
  },
  { import = "community" },
  { import = "plugins" },
  { import = "plugins.dap" },
}

---@type LazyConfig
local opts = {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "catppuccin" } },
  ui = { backdrop = 100 },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
}

require("lazy").setup(spec, opts)

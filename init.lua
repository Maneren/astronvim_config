--              AstroNvim Configuration Table
local config = {
  colorscheme = "catppuccin",
  options = {
    opt = {
      relativenumber = false, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
    },
  },
  plugins = {
    init = {
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end,
      },
      {
        "wakatime/vim-wakatime"
      }
    },
  },
}

return config

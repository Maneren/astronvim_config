return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "HUAHUAI23/telescope-dapzzzz" },
    { "nvim-telescope/telescope-dap.nvim" },
  },
  config = function(opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("i23")
    telescope.load_extension("dap")
  end,
  lazy = false,
}
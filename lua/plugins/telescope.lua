---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "HUAHUAI23/telescope-dapzzzz" },
    { "nvim-telescope/telescope-dap.nvim" },
  },
  config = function(plugin, opts)
    require("astronvim.plugins.configs.telescope")(plugin, opts)
    require("telescope").load_extension("i23")
  end,
}

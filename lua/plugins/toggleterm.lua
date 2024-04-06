---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  opts = {
    on_open = function() vim.cmd("startinsert") end,
  },
}

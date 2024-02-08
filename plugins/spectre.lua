return {
  "nvim-pack/nvim-spectre",
  event = "BufRead",
  build = "sh build.sh",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    default = {
      replace = {
        cmd = "oxi",
      },
    },
  },
}

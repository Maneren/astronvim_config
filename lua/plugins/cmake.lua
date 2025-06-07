---@type LazySpec
return {
  "Civitasv/cmake-tools.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "cmake" },
  opts = {
    cmake_build_directory = "build",
    cmake_executor = {
      name = "toggleterm",
    },
    cmake_runner = {
      name = "toggleterm",
    },
    cmake_virtual_text_support = true,
    cmake_use_scratch_buffer = true,
  },
}

--- Hexeditor inside nvim
--- https://github.com/RaafatTurki/hex.nvim

---@type LazySpec
return {
  "RaafatTurki/hex.nvim",
  cmd = {
    "HexDump",
    "HexAssemble",
    "HexToggle",
  },
  opts = {
    dump_cmd = "xxd -g 1 -u",
    assemble_cmd = "xxd -r",
  },
}

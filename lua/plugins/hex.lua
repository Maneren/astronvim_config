-- xxd integration

---@type LazySpec
return {
  "RaafatTurki/hex.nvim",
  cmd = {
    "HexDump",
    "HexAssemble",
    "HexToggle",
  },
  opts = {
    assemle_cmd = "sed -z '$ s/\n$//' | xxd -r",
  },
}

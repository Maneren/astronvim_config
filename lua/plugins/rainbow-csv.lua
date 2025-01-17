--- Rainbow colors for CSV files
--- https://github.com/cameron-wags/rainbow_csv.nvim

---@type LazySpec
return {
  "cameron-wags/rainbow_csv.nvim",
  opts = {},
  ft = {
    "csv",
    "tsv",
    "csv_semicolon",
    "csv_whitespace",
    "csv_pipe",
    "rfc_csv",
    "rfc_semicolon",
  },
  cmd = {
    "RainbowDelim",
    "RainbowDelimSimple",
    "RainbowDelimQuoted",
    "RainbowMultiDelim",
  },
}

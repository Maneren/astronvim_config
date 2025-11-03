local M = {}

function M.parse_args()
  local input = vim.fn.input("Arguments: ")

  -- Credit: https://github.com/mfussenegger/nvim-dap/discussions/1160

  local tokens = {}
  local current = ""
  local in_str = false
  local str_seek

  for c in string.gmatch(input, ".") do -- iterate through all chars
    if c == " " and not in_str then
      if string.len(current) > 0 then
        table.insert(tokens, current)
        current = ""
      end
    elseif c == '"' and not in_str then
      in_str = true
      str_seek = '"'
    elseif c == "'" and not in_str then
      in_str = true
      str_seek = "'"
    elseif c == str_seek and in_str then
      in_str = false
      table.insert(tokens, current)
      current = ""
    else
      current = current .. c
    end
  end
  if string.len(current) > 0 then
    table.insert(tokens, current)
  end
  return tokens
end

return M

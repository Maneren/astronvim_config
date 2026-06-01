return {
  "monaqa/dial.nvim",
  opts = {},
  init = function()
    local augend = require("dial.augend")

    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.constant.alias.Bool,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.semver.alias.semver,
      },
    }
  end,
}

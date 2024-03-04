local rewin = require("rewin")
rewin.setup {
}

local eslint = require("eslint")

eslint.setup({
  bin = 'eslint_d',
  code_actions = {
    enable = true,
    disable_rule_comment = {
      enable = true,
      location = "same_line",
    },

  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type",
  }
})

require("flash").setup({
  modes = {
    search = {
      enabled = false
    }
  }
})


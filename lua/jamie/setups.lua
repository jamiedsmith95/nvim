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

require("neogit").setup({

  kind = "floating",
  commit_select_view = {
    kind = "floating"
  },
  commit_editor = {
    kind = "floating"
  },
  commit_view = {
    kind = "floating"
  },
  popup = {
    kind = "floating"
  }


})

require('gitsigns').setup({
  signcolumn = true,
  signs = {
    add = {text = '+'},
    change = {text = '~'},
    delete = {text = '-'},
    untracked = {text = '?'}
  }
})
require("flash").setup({
  modes = {
    search = {
      enabled = false
    }
  }
})

require("which-key").setup {

}

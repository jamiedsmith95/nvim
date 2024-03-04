local rewin = require("rewin")
rewin.setup {
}

<<<<<<< HEAD
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

=======
require("neogit").setup({

  kind = "floating",
  commit_select_view = {
    kind = "floating"
  },
  commit_editor = {
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
>>>>>>> bbf8ee7f636f8bc762f7f8bf40c3ac3bac3d6a27
require("flash").setup({
  modes = {
    search = {
      enabled = false
    }
  }
})


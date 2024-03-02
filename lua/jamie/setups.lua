local rewin = require("rewin")
rewin.setup {
}

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
require("flash").setup({
  modes = {
    search = {
      enabled = false
    }
  }
})


local rewin = require("rewin")
rewin.setup {
}

require("neogit").setup({

})

require('gitsigns').setup({
  signcolumn = true
})
require("flash").setup({
  modes = {
    search = {
      enabled = false
    }
  }
})


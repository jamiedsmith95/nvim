local rewin = require("rewin")
rewin.setup {
}

require('which-key').setup({})

require('visual').setup({
  treesitter_textobjects = true,
  nunmaps = { "W", "E", "B", "w", "e", "b", "c" },
  commands = {


    sd_inside2 = {
      pre_amend = { "<esc>", "<sdi>i" },
      post_amend = {},
      modes = { "sd", "n" },
      amend = false,
      countable = false
    },
    sd_around2 = {
      pre_amend = { "<esc>", "<sdi>a" },
      post_amend = {},
      amend = false,
      modes = { "sd", "n" },
      countable = false
    }

  },
  mappings = {
    toggle_serendipity = ".",
    sd_inside2 = "<leader>i",
    sd_around2 = "<leader>a",
  },
})

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
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    untracked = { text = '?' }
  }
})
require("flash").setup({
  modes = {
    search = {
      enabled = false
    }
  }
})

local rewin = require("rewin")
rewin.setup( {
})

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
  }})
require('which-key').setup({})

require('visual').setup({
  treesitter_textobjects = true,
  nunmaps = { "W", "E", "B", "w", "e", "b", "c" },
  commands = {


    line_visual2 = {
      pre_amend = { "<s-v>" },
      post_amend = {},
      modes = { "n" },
      amend = false,
      countable = true
    },
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
    line_visual = "y",
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

require("which-key").setup({

})

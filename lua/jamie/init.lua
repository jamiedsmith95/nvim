require("jamie.oil")
require("jamie.setting")
require("jamie.lualine")
require("jamie.lsp-zero")
require("jamie.harpoon")
require('jamie.packer')
require('telescope').setup()
require("jamie.lsp")
require("jamie.webtools")
require("jamie.dap")
require("jamie.telescope")
require("jamie.rtools")
require("jamie.vimtex")
require('jamie.tabnine')
require('jamie.setups')
require("jamie.treesitter")
require("jamie.ts-context")
-- require("jamie.bufferline")
require("jamie.illuminate")
require("jamie.cmp")
--require("jamie.lspkind")
require("jamie.cbyu")
require("jamie.autopairs")
-- require("jamie.navic")
-- require("jamie.copilot")
-- require("jamie.commands")
require("jamie.remap")
-- require('jamie.noice')
vim.opt.termguicolors = true
-- require("bufferline").setup{}
require'lspconfig'.tsserver.setup {}
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- use {
  --   'folke/noice.nvim',
  --   requires = {'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify'},
  -- }
  use 'christoomey/vim-tmux-navigator'
  use {
    'stevearc/oil.nvim',
  }
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x', -- commit ='4cccb6f494eb255b32a290d37c35ca12584c74d0'
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'BurntSushi/ripgrep'
  use 'jamiedsmith95/rewin'
  -- use '/home/jsmith49/rewin'
  use 'xiyaowong/transparent.nvim'
  use 'mxsdev/nvim-dap-vscode-js'
  use 'leoluz/nvim-dap-go'
  use 'folke/flash.nvim'
  use 'echasnovski/mini.jump2d'
  use 'lervag/vimtex'
  use 'ray-x/web-tools.nvim'
  use 'morhetz/gruvbox'
  use 'mg979/vim-visual-multi'
  use 'simrat39/rust-tools.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  -- use 'justinmk/vim-sneak'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  --use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use { 'onsails/lspkind.nvim' }
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  -- use {"kyazdani42/nvim-web-devicons"}
  use { 'ghillb/cybu.nvim' }
  use 'nvim-tree/nvim-web-devicons'
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { 'romainl/vim-qf' }
  use 'Mofiqul/dracula.nvim'
  use { "hrsh7th/cmp-path" } -- path completions
  use { "hrsh7th/vscode-langservers-extracted" }
  use { "shmup/vim-sql-syntax" }
  use { "saadparwaiz1/cmp_luasnip" }     -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }         -- lsp completions
  use { "hrsh7th/cmp-nvim-lua" }         -- lua completions
  -- snippets
  use { "L3MON4D3/LuaSnip" }             --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use
  use { "catppuccin/nvim", as = "catppuccin" }
  use "sainnhe/sonokai"
  use 'jacoborus/tender'
  use 'voldikss/vim-floaterm'
  use 'nacro90/numb.nvim'
  use 'andymass/vim-matchup'
  use 'folke/zen-mode.nvim'
  use 'windwp/nvim-autopairs'
  use 'ggandor/leap.nvim'
  use 'karb94/neoscroll.nvim'
  use 'junegunn/vim-slash'
  use 'vuciv/vim-bujo'
  use 'tpope/vim-abolish'
  -- use "zbirenbaum/copilot-cmp"
  -- use { "zbirenbaum/copilot.lua" }
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'machakann/vim-highlightedyank'
  use 'MunifTanjim/nui.nvim'
  use 'ellisonleao/glow.nvim'
  use 'vimwiki/vimwiki'
  use 'tpope/vim-commentary'
  use 'glepnir/dashboard-nvim'
  -- use 'bling/vim-bufferline'



  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  -- use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" } -- LSP Higlight
  -- use ({
  --   'nvimdev/lspsaga.nvim',
  --   after = 'nvim-lspconfig',
  --   config = function()
  --       require('lspsaga').setup({})
  --   end,
  -- })
  --  use { "glepnir/lspsaga.nvim" } -- LSP UI
  --
  use 'VonHeikemen/lsp-zero.nvim'
  use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
  }
  use { "MunifTanjim/eslint.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "ray-x/lsp_signature.nvim" }
  -- use { "williamboman/mason.nvim" } -- LSP Installer
  -- using packer.nvim
  -- use({
  -- 	'jameshiew/nvim-magic',
  -- 	config = function()
  -- 		require('nvim-magic').setup()
  --   end,
  -- 	requires = {
  -- 		'nvim-lua/plenary.nvim',
  -- 		'MunifTanjim/nui.nvim'
  -- 	}
  --})
  -- use 'nrsh7th/cmp-nvilsp'
  -- use 'nrsh7th/cmp-buffer'
  -- use 'nrsh7th/cmp-path'
  -- use 'nrsh7th/cmp-cmdline'
  -- use 'nrsh7th/cmp-cmp'

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", }
  use { "nvim-treesitter/nvim-treesitter-context" }
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })

  -- use 'p00f/nvim-ts-rainbow'
end)

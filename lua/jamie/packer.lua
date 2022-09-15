vim.cmd("packadd packer.nvim")
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'justinmk/vim-sneak'
--  use { "catppuccin/nvim", as = "catppuccin" }
  use 'jacoborus/tender'
  use 'nacro90/numb.nvim'
  use 'andymass/vim-matchup'
  use 'folke/zen-mode.nvim'
  use 'windwp/nvim-autopairs'
  use 'karb94/neoscroll.nvim'
  use 'junegunn/vim-slash' 
  use 'folke/which-key.nvim'
  use 'vuciv/vim-bujo'
  use 'tpope/vim-abolish'
  use "zbirenbaum/copilot-cmp"
  use { "zbirenbaum/copilot.lua" }
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'machakann/vim-highlightedyank'
  use 'MunifTanjim/nui.nvim'
  use 'ellisonleao/glow.nvim'
  use 'vimwiki/vimwiki'
  use 'tpope/vim-commentary'
  use 'glepnir/dashboard-nvim'
  use 'bling/vim-bufferline'
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" } -- lsp completions
  use { "hrsh7th/cmp-nvim-lua" } -- lua completions
 -- use { "rcarriga/cmp-dap" }
  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" } -- LSP Higlight
  use { "glepnir/lspsaga.nvim" } -- LSP UI
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "ray-x/lsp_signature.nvim" }
  use { "pboettch/vim-highlight-cursor-words" }
--  use { "williamboman/mason.nvim" } -- LSP Installer
--  use { "williamboman/mason-lspconfig.nvim" } -- LSP Configuration
  -- using packer.nvim
use({
	'jameshiew/nvim-magic',
	config = function()
		require('nvim-magic').setup()
  end,
	requires = {
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim'
	}
})
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
 --or                            , branch = '0.1.x',
   requires = { {'nvim-lua/plenary.nvim'} }
  -- use 'nrsh7th/cmp-nvilsp'
  -- use 'nrsh7th/cmp-buffer'
  -- use 'nrsh7th/cmp-path'
  -- use 'nrsh7th/cmp-cmdline'
  -- use 'nrsh7th/cmp-cmp'
}
  use {"nvim-treesitter/nvim-treesitter",run = ":TSUpdate",}
  use 'p00f/nvim-ts-rainbow'
end)

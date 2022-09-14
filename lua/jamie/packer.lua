vim.cmd("packadd packer.nvim")
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- use 'nrsh7th/cmp-nvilsp'
  -- use 'nrsh7th/cmp-buffer'
  -- use 'nrsh7th/cmp-path'
  -- use 'nrsh7th/cmp-cmdline'
  -- use 'nrsh7th/cmp-cmp'
  use 'justinmk/vim-sneak'
  -- use 'neovim/nvim-lspconfig'
  use {"nvim-treesitter/nvim-treesitter",run = ":TSUpdate",}
  use 'jacoborus/tender.vim'
  use 'vuciv/vim-bujo'
  use 'tpope/vim-abolish'
--  use 'neoclide/coc.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'machakann/vim-highlightedyank'
  use 'MunifTanjim/nui.nvim'
  use 'ellisonleao/glow.nvim'
  use 'vimwiki/vimwiki'
  use 'tpope/vim-commentary'
  use 'glepnir/dashboard-nvim'
  use 'bling/vim-bufferline'
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
-- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
}
end)

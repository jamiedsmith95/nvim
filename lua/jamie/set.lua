
local set = vim.opt
vim.opt.nu = true
vim.opt.shiftwidth=2
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.lazyredraw = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.scrolloff = 9
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartindent = true

vim.opt.wrap = true
vim.g.mapleader = " "
vim.opt.mouse = ""
vim.opt.tabstop = 2
vim.opt.softtabstop = 1

vim.cmd([[
    :command! SavePlace :normal y"aT^ y"A<space> y"At$
    set noswapfile
    function! ToWhat()
        let c = nr2char(getchar())
        execute 'normal! F'.c'<CR>n'
        startinsert
    endfunction
    function! Towhat()
        let c = nr2char(getchar())
        execute 'normal! f'.c'<CR>n'
        startinsert
    endfunction
    function! Toword()
        execute 'normal! /\*<CR>2n'
        startinsert
    endfunction
    

      
          
          



    function! Nows()
        let n = line('.')
        execute 'normal! :%s/^\s*$\n^\s*$\n//eg'
        execute 'normal! :%s/s+$//eg'
        execute 'normal! :'.n
    endfunction
    let g:loaded_clipboard_provider = 1
    let &shell='/bin/bash --rcfile /home/jsmith49/.profile'
    let g:netrw_silent=1
    let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
]])


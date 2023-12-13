local o = vim.opt
vim.cmd("let g:gruvbox_transparent_bg = '1'")
vim.cmd("colorscheme sonokai")
vim.cmd("let g:gruvbox_transparent_bg = '1'")


vim.opt.nu = true
vim.opt.shiftwidth = 2
--vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.lazyredraw = false
vim.opt.clipboard = "unnamedplus"
vim.opt.autochdir = false
vim.opt.completeopt = { "menuone", "noselect", "menu" }
vim.opt.termguicolors = true
--vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.winbar = ''
vim.opt.scrolloff = 9
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.pumblend = 25
vim.opt.wrap = true
vim.g.mapleader = " "
vim.opt.tabstop = 2
vim.opt.softtabstop = 1
--vim.highlight.create('MyHi', {ctermfg=246, guifg=SeaGreen, guibg=#444444}, false)


--hi myhi ctermfg=246 ctermbg=Search guibg=#444444
vim.cmd([[
    au FileType qf call AdjustWindowHeight(1, 1)
    function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
    endfunction
    hi VisualNc guifg=#B83998 guibg=#ABB2BF
    :command! SavePlace :normal y"aT^ y"A<space> y"At$
    set noswapfile
    set mouse=""
    set signcolumn=yes:1
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
        execute 'normal! *<CR>2n'
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
    -- augroup highlight_current_word
    -- au!
    -- au CursorMoved * :silent exec 'match VisualNc /\V\<' . expand('<cword>') . '\>/'
    -- :set updatetime=100
    -- augroup END

eval %sh{ kak-tree-sitter  -dks --init "$kak_session"}
colorscheme catppuccin_macchiato
define-command -override tree-sitter-user-after-highlighter %{
  add-highlighter	-override buffer/ number-lines -hlcursor -relative -separator " "
  add-highlighter -override buffer/ show-matching
  add-highlighter -override buffer/ wrap -indent
  colorscheme mygruvbox
  # set-face global comment +Fd
}
colorscheme mygruvbox
set global jumpclient jump
hook global InsertChar \t %{ exec -draft -itersel h@ }
add-highlighter	-override global/ number-lines -hlcursor -relative -separator " "
add-highlighter -override global/ show-matching
set global aligntab true
set-option global tabstop 4
set-option global indentwidth 4
set-option global scrolloff 20,20
# set-face global CurWord +b
declare-option int col_num 1
hook global ClientCreate .* %{
    set-option global ui_options terminal_assistant=off
    set-option -add global ui_options terminal_enable_mouse=false
  }

define-command  open-config %{
  execute-keys -with-hooks ':edit ~/.config/kak/kakrc<ret>'
  }

define-command  open-lsp-config %{
  execute-keys -with-hooks ':edit ~/.config/kak-lsp/kak-lsp.toml<ret>'
  }

hook global InsertCompletionShow .* %{
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
}

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

 

map -docstring "close current buffer" global user d ": db<ret>"
map -docstring "goto previous buffer" global user p ": bp<ret>"
map -docstring "goto next buffer" global user n ": bn<ret>"

evaluate-commands %sh{
        plugins="$kak_config/plugins"
            mkdir -p "$plugins"
                [ ! -e "$plugins/plug.kak" ] && \
                        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
                            printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}
plug "andreyorst/plug.kak" noload 


map global user / '/' -docstring "case insensitive search"
map global normal / '/(?c)' -docstring "smartcase search"

plug 'natasky/kakoune-multi-file'

plug "alexherbo2/auto-pairs.kak" config %{
  enable-auto-pairs
}


define-command convert_date_to_iso_8601 %{
  execute-keys '|date -I -d "$kak_selection"<ret>'
}

plug "andreyorst/powerline.kak" defer powerline_gruvbox %{
      powerline-theme gruvbox
} config %{
      powerline-start
}

plug "evanrelf/byline.kak" config %{
  require-module byline
}


# fzf
plug "andreyorst/fzf.kak" config %{
      require-module fzf
        require-module fzf-grep
          require-module fzf-file
          require-module fzf-buffer
} defer fzf %{
      set-option global fzf_highlight_command 'batcat --color=always --style=plain {}'
} defer fzf-file %{
      set-option global fzf_file_command rg
} defer fzf-grep %{
      set-option global fzf_grep_command rg
}
set global fzf_preview true
set global fzf_tmux_popup true
set global fzf_grep_preview true
set global fzf_use_main_selection false

map -docstring "open fzf" global user f ": fzf-mode<ret>"

# lsp mappings
map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'


plug "anhsirk0/kakoune-themes" theme
plug "delapouite/kakoune-text-objects"

plug "kak-lsp/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path .
} config %{

    # uncomment to enable debugging
    # eval %sh{echo ${kak_opt_lsp_cmd} >> /tmp/kak-lsp.log}
    # set global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"

    # this is not necessary; the `lsp-enable-window` will take care of it
    # eval %sh{${kak_opt_lsp_cmd} --kakoune -s $kak_session}

    set global lsp_diagnostic_line_error_sign '║'
    set global lsp_diagnostic_line_warning_sign '┊'
    set global lsp_hover_max_info_lines 4
    set global lsp_hover_max_diagnostic_lines 10

    define-command ne -docstring 'go to next error/warning from lsp' %{ lsp-find-error --include-warnings }
    define-command pe -docstring 'go to previous error/warning from lsp' %{ lsp-find-error --previous --include-warnings }
    define-command ee -docstring 'go to current error/warning from lsp' %{ lsp-find-error --include-warnings; lsp-find-error --previous --include-warnings }

    # define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }
    map global lsp t ':try %{lsp-inlay-hints-enable buffer} catch %{lsp-inlay-hints-disable buffer}<ret>' -docstring 'toggle lsp-inlay-hints'
    map global lsp T ':try %{lsp-inlay-diagnostics-enable buffer} catch %{lsp-inlay-diagnostics-disable buffer}<ret>' -docstring 'toggle lsp-inlay-diagnostics'



    hook global KakEnd .* lsp-exit
}
# hook global InsertMove .* %{
#   hook global -once RawKey (<up>|<down>) %{
#     hook global -once NormalIdle .* %{
#     execute-keys vv
#     }
#   }
# } 

plug "https://git.sr.ht/~raiguard/kak-one" theme
plug 'delapouite/kakoune-mirror' %{
    map global normal "'" ": enter-user-mode -lock mirror<ret>"
}

hook global WinSetOption filetype=(typescript|rust|python|yaml|php|haskell|cpp|latex|c#|racket) %{
    lsp-enable-window
        echo -debug "Enabling LSP for filtetype %opt{filetype}"
    set-option global lsp_show_hover_format 'printf "%.500s \n" "${lsp_info}" "${lsp_diagnostics}"'
    

    

    # hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    # hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    # hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens

}

hook global WinSetOption filetype=(typescript) %{
lsp-auto-hover-enable
set window indentwidth 2
set window tabstop 2
lsp-auto-signature-help-enable
  eval %{ add-highlighter -override window/ ref typescript}
}

hook global WinSetOption filetype=(rust) %{
  # set window formatcmd "rustfmt --edition=2021 "
  lsp-auto-hover-buffer-enable
  lsp-auto-signature-help-enable
  eval %{ add-highlighter -override window/ ref rust}
}

hook global WinSetOption filetype=(python) %{
  lsp-auto-hover-buffer-enable
  lsp-auto-signature-help-enable
  set-face window documentation default,default,default+d
  add-highlighter window/mypy regions
  # set-option window lintcmd "flake8 --filename='*' --format='%%(path)s:%%(row)d:%%(col)d: error: %%(text)s' --ignore=E121,E123,E126,E226,E24,E704,W503,W504,E501,E221,E127,E128,E129,F405"
  # add-highlighter window/indent show-whitespaces -indent '|' -lf ' ' -tab ' ' -tabpad ' ' -nbsp '-' -spc '.'
  set window indentwidth 4
  set window tabstop 4
  set-option window formatcmd "black -"
  source ~/.config/kak/pyish.kak
  # source ~/.config/kak/py.kak
  eval %{ add-highlighter -override window/python ref python }
}
    
    hook global WinSetOption filetype=sh %{
      set-option window lintcmd "shellcheck -x -f gcc -Cnever -a"
      set-option buffer formatcmd "shfmt -i 4"
      declare-user-mode lint-shell
      map global user 'L' ': enter-user-mode lint-shell<ret>'  -docstring 'enter lint mode'
      map global lint-shell 'l' ': lint<ret>'                  -docstring 'update lint'
      map global lint-shell 'n' ': lint-next-message<ret>'     -docstring 'next error'
      map global lint-shell 'p' ': lint-previous-message<ret>' -docstring 'previous error'


}

hook global WinSetOption filetype=(csv) %{
  declare-user-mode csv-mode
  csv-colour-rgx
  map global user a ': enter-user-mode csv-mode<ret>' -docstring 'csv mode'
  add-highlighter window/csv-regions regions
  map global csv-mode c ': csv-colour-rgx<ret>' -docstring 'create regex for column'
  map global csv-mode r ': csv-next-col<ret>' -docstring 'set register to match columns'
  map global csv-mode h ':add-highlighter window/csv regex %opt{col_rgx} %opt{col_faces}<ret>' -docstring 'Highlight columns'
  map global csv-mode s ': col-select<ret>' -docstring 'Select current column'
  map global csv-mode ) ': col-swap-forward<ret>' -docstring 'Swap column with next column'
  map global csv-mode n ': col-extend<ret>' -docstring 'Extend column selection'
  map global csv-mode N ': col-extend-back<ret>' -docstring 'Extend column selection backwards'
  map global csv-mode <a-(> ': col-swap-back<ret>' -docstring 'Swap column with previous column'

}


plug "caksoylar/kakoune-focus" config %{
          }
plug 'alexherbo2/connect.kak' config %{
  map global user r %{:connect lf %val{buffile} <ret>} -docstring 'lf'
}


map global user <space> ': focus-toggle<ret>' -docstring "toggle selection focus"
plug 'jordan-yee/kakoune-git-mode' config %{
    declare-git-mode
    map global user g ': enter-user-mode git<ret>' -docstring "git mode"
    map global git o ': tmux-terminal-window lazygit<ret>' -docstring "open lazygit in new window"
}

plug 'delapouite/kakoune-palette'

plug 'the-mikedavis/coerce.kak' %{
  map global normal = ': coerce-mode<ret>'
}


# git conflict
map global object m %{c^[<lt>=]{4\,}[^\n]*\n,^[<gt>=]{4\,}[^\n]*\n<ret>} -docstring 'conflict markers'
define-command conflict-use-1 %{
  evaluate-commands -draft %{
    execute-keys <a-h>h/^<lt>{4}<ret>xd
    execute-keys h/^={4}<ret>j
    execute-keys -with-maps <a-a>m
    execute-keys d
  }
} -docstring "resolve a conflict by using the first version"

define-command conflict-use-2 %{
  evaluate-commands -draft %{
    execute-keys j
    execute-keys -with-maps <a-a>m
    execute-keys dh/^>{4}<ret>xd
  }
} -docstring "resolve a conflict by using the second version"
source ~/.config/kak/csv.kak
plug "natasky/kakoune-multi-file"
plug "delapouite/kakoune-user-modes" %{
  map global user a ': enter-user-mode anchor<ret>'   -docstring 'anchor mode'
  map global user E ': enter-user-mode echo<ret>'     -docstring 'echo mode'
  map global user F ': enter-user-mode format<ret>'   -docstring 'format mode'
  map global user i ': enter-user-mode enter<ret>'    -docstring 'enter mode'
  map global user k ': enter-user-mode keep<ret>'     -docstring 'keep mode'
  map global user T ': enter-user-mode lint<ret>'     -docstring 'lint mode'
  map global user r ': enter-user-mode rotation<ret>' -docstring 'rotation mode'


}
plug 'delapouite/kakoune-hump' %{
  # Suggested mappings
  map global normal <a-h> ': select-previous-hump<ret>' -docstring 'select prev hump'
  map global normal h ': select-next-hump<ret>'     -docstring 'select next hump'
  map global normal <a-H> ': extend-previous-hump<ret>' -docstring 'extend prev hump'
  map global normal H ': extend-next-hump<ret>'     -docstring 'extend next hump'
}
map global user t ":enter-user-mode tree-sitter<ret>"
define-command -override kak-tree-sitter-set-lang %{
  set-option buffer kts_lang %opt{filetype}
}

plug "andreyorst/kaktree" config %{
    hook global WinSetOption filetype=kaktree %{
        map buffer normal <up> 'kx'
        map buffer normal <down> 'jx'
        try %{
        remove-highlighter buffer/numbers
        }
        try %{
        remove-highlighter buffer/matching
        }
        try %{
        remove-highlighter buffer/wrap
        }
        try %{
        remove-highlighter buffer/show-whitespaces
        }

    }
    kaktree-enable
}
map global user e ":kaktree-toggle<ret>" -docstring "toggle kaktree filetree"
map global normal <ret> 'vv'
map global insert <s-backspace> "<a-;>Bc"
map global user o ":fzf-mode<ret>b" -docstring "Open buffer picker"
map global user N ":tmux-terminal-vertical noter<ret>" -docstring "Open notes"
map global normal m <a-i>
map global normal <backspace> b
map global normal <s-backspace> B
map global normal <s-left> B
map global normal <s-right> W
map global normal M <a-a>
map global normal <c-f> <c-o>
# map global normal = <a-+>
map global user s ':enter-user-mode selectors<ret>' -docstring 'selectors'
map global user b ':e *debug*<ret>'
# leave insert mode when changing line
map global insert <up> '<esc>k'
map global insert <down> '<esc>j'
map global normal <tab> '<c-i>'
map global normal <s-tab> '<c-o>'
map global normal <c-x> <c-s>
map global insert <c-s> <esc>
map global normal <end> "gl"
map global normal <home> "gh"
map global normal <c-s> ':write<ret>'
map global user c ':open-config<ret>' -docstring 'open kak config'
map global user L ':open-lsp-config<ret>' -docstring 'open kak-lsp config'
map global normal "#" ":comment-line<ret>"

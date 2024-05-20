hook global InsertChar \t %{ exec -draft -itersel h@ }
set-option global tabstop 2
set-option global indentwidth 2
set-option global scrolloff 8,3
set-face global CurWord +b
declare-option int col_num 1
add-highlighter	global/ number-lines -hlcursor -relative -separator " "
add-highlighter global/ show-matching
add-highlighter global/ wrap -indent
hook global ClientCreate .* %{
    set-option global ui_options terminal_assistant=off
    set-option -add global ui_options terminal_enable_mouse=false
  }

define-command  open-config %{
  execute-keys -with-hooks ':edit ~/.config/kak/kakrc<ret>'
  }

hook global WinSetOption filetype=(typescript) %{
  colorscheme gruvbox-dark
}

hook global InsertCompletionShow .* %{
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
}

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}


map global normal <c-f> <c-o>
map global normal = <a-+>
map global user s ':enter-user-mode selectors<ret>' -docstring 'selectors'
map global user b ':e *debug*<ret>'
# leave insert mode when changing line
map global insert <up> '<esc>k'
map global insert <down> '<esc>j'

map global normal <c-x> <c-s>
map global insert <c-s> <esc>
map global normal <end> "gl"
map global normal <home> "gh"
map global normal <c-s> ':write<ret>'
map global user c ':open-config<ret>' -docstring 'open kak config'
map global normal "#" ":comment-line<ret>"
 

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


map global user / '/(?i)' -docstring "case insensitive search"


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
map global normal = '|fmt -w $kak_opt_autowrap_column<ret>'
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'


plug "anhsirk0/kakoune-themes" theme
plug "delapouite/kakoune-colors" theme
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

    define-command ne -docstring 'go to next error/warning from lsp' %{ lsp-find-error --include-warnings }
    define-command pe -docstring 'go to previous error/warning from lsp' %{ lsp-find-error --previous --include-warnings }
    define-command ee -docstring 'go to current error/warning from lsp' %{ lsp-find-error --include-warnings; lsp-find-error --previous --include-warnings }

    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    hook global WinSetOption filetype=(rust) %{
        set window lsp_server_configuration rust.clippy_preference="on"
    }

    hook global WinSetOption filetype=rust %{
        hook window BufWritePre .* %{
            evaluate-commands %sh{
                test -f rustfmt.toml && printf lsp-formatting-sync
            }
        }
    }

    hook global KakEnd .* lsp-exit
}

plug "https://git.sr.ht/~raiguard/kak-one" theme

hook global WinSetOption filetype=(typescript|rust|python|php|haskell|cpp|latex|c#|racket) %{
    lsp-enable-window
        echo -debug "Enabling LSP for filtetype %opt{filetype}"
    lsp-auto-hover-enable
    set-option global lsp_hover_anchor true
    set-option global lsp_show_hover_format 'printf %s \n %s "${lsp_diagnostics}"'
    lsp-auto-signature-help-enable
    

    lsp-inlay-hints-enable window
    lsp-inlay-diagnostics-enable global
    

    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
}

    hook global WinSetOption filetype=(python) %{
      colorscheme pastel
      set-face window documentation default,default,default+d
      jedi-enable-autocomplete
      add-highlighter window/mypy regions
      # set-option window lintcmd "flake8 --filename='*' --format='%%(path)s:%%(row)d:%%(col)d: error: %%(text)s' --ignore=E121,E123,E126,E226,E24,E704,W503,W504,E501,E221,E127,E128,E129,F405"
      # add-highlighter window/indent show-whitespaces -indent '|' -lf ' ' -tab ' ' -tabpad ' ' -nbsp '-' -spc '.'
      set window indentwidth 4
      set window tabstop 4
      set-option window formatcmd "black -"
      source ~/.config/kak/py.kak
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
  map window user a ': enter-user-mode csv-mode<ret>' -docstring 'csv mode'
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
plug "danr/kakoune-easymotion" config %{
  map global user t ': enter-user-mode easymotion<ret>' -docstring 'easymotion'
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

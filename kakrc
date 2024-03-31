colorscheme one-dark-16
hook global InsertChar \t %{ exec -draft -itersel h@ }
set-option global tabstop 2
set-option global indentwidth 2
set-option global scrolloff 8,3

add-highlighter	global/ number-lines -hlcursor -relative -separator " "
add-highlighter global/ show-matching
add-highlighter global/ wrap -indent
set global debug hooks
hook global ClientCreate .* %{
    set-option global ui_options terminal_assistant=off
    execute-keys ':echo "setting assistant off"<ret>'
    set-option global ui_options terminal_enable_mouse=false
  }

define-command open-config %{
  execute-keys ':edit ~/.config/kak/kakrc<ret>'
  }

hook global WinSetOption filetype=(typescript) %{
  colorscheme gruvbox-dark
}

hook global WinSetOption filetype=(python) %{
  colorscheme palenight
  }

hook global InsertCompletionShow .* %{
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
}

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}




# leave insert mode when changing line
map global insert <up> '<esc>k'
map global insert <down> '<esc>j'
map global insert <c-s> <esc>
map global normal <end> "gl"
map global normal <home> "gh"
map global normal <c-s> ':write<ret>'
map global normal S '\%s'
map global user c ':open-config<ret>'
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

plug "andreyorst/plug.kak" noload config %{
}


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
      set-option global fzf_highlight_command 'batcat --color=always --line-range=:500 {@}'
} defer fzf-file %{
      set-option global fzf_file_command rg
} defer fzf-grep %{
      set-option global fzf_grep_command rg
}
set global fzf_preview true

set global fzf_grep_preview true
set global fzf_use_main_selection false

map -docstring "open fzf" global user f ": fzf-mode<ret>"
map -docstring "open lsp" global user l ": enter-user-mode lsp<ret>"

plug "kak-lsp/kak-lsp" do %{
        cargo install --locked --force --path .
            # optional: if you want to use specific language servers
         mkdir -p ~/.config/kak-lsp
         cp -n kak-lsp.toml ~/.config/kak-lsp/
}
plug "https://git.sr.ht/~raiguard/kak-one" theme

plug "caksoylar/kakoune-focus" config %{
          }

map global user <space> ': focus-toggle<ret>' -docstring "toggle selection focus"
plug 'jordan-yee/kakoune-git-mode' config %{
    declare-git-mode
    map global user g ': enter-user-mode git<ret>' -docstring "git mode"
    map global git o ': tmux-terminal-window lazygit<ret>' -docstring "open lazygit in new window"
}


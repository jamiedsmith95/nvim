colorscheme palenight


hook global InsertChar \t %{ exec -draft -itersel h@ }
set global tabstop 2
set global indentwidth 2
set global scrolloff 8,3
set-option global ui_options terminal_assistant=cat

add-highlighter	global/ number-lines -hlcursor -relative -separator " "
add-highlighter global/ show-matching
add-highlighter global/ wrap -indent


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
map global normal <space> ,
map global normal x X

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


plug "secondary-smiles/kakoune-themes" theme config %{
}

plug "gustavo-hms/luar" %{
      require-module luar
}

plug "andreyorst/powerline.kak" defer powerline_gruvbox %{
      powerline-theme gruvbox
} config %{
      powerline-start
}



# fzf
plug "andreyorst/fzf.kak" config %{
      require-module fzf
        require-module fzf-grep
          require-module fzf-file
} defer fzf %{
      set-option global fzf_highlight_command "lat -r {}"
} defer fzf-file %{
      set-option global fzf_file_command "fd . --no-ignore-vcs"
} defer fzf-grep %{
      set-option global fzf_grep_command "fd"
}
map -docstring "open fzf" global user f ": fzf-mode<ret>"
map -docstring "open lsp" global user l ": enter-user-mode lsp<ret>"

plug "kak-lsp/kak-lsp" do %{
        cargo install --locked --force --path .
            # optional: if you want to use specific language servers
         mkdir -p ~/.config/kak-lsp
         cp -n kak-lsp.toml ~/.config/kak-lsp/
         }

plug "caksoylar/kakoune-focus" config %{
         # configuration here
          }
map global user <space> ': focus-toggle<ret>' -docstring "toggle selection focus"
plug 'jordan-yee/kakoune-git-mode' config %{
    declare-git-mode
    map global user g ': enter-user-mode git<ret>' -docstring "git mode"
    map global git o ': tmux-terminal-window lazygit<ret>' -docstring "open lazygit in new window"
}


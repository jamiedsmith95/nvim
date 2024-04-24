map global normal <a-z> <a-x>
define-command csv-column  %{
  evaluate-commands %{
    set window col_num %sh{
      sed ''$kak_cursor_line'q;d' $kak_bufname | cut -c 1-$kak_cursor_column | csvtool width '-'
    }
}
}

declare-option -hidden range-specs csv_colour_col
declare-option regex csv_columns (?:,|^)("(?:(?:"")*[^"]*)*"|[^",\n]*|(?:\n|$))
declare-option int-list csvcount

declare-option str-list column_faces "red" "green" "blue" "magenta" "cyan"

define-command -docstring "Colour the columns of the csv" csv-colour %{
  set-option window csv_colour_col "%val{timestamp}"
  try %{
    add-highlighter window/ ranges csv_colour_col
  }
  evaluate-commands -save-regs '/' -draft %{
    set-register / "%opt{csv_columns}"
    execute-keys \%<a-s>
    set window csvcount 999
    try %{
      column-selection 0
    }
  }
}

define-command -hidden column-selection -params 1 %{
  evaluate-commands %sh{
    index=$1
    eval "set -- $kak_quoted_opt_column_faces"
    length=$#
    next_index=$(( (index +1) % (length - 1) ))
    index=$(( index + 1 ))
    eval face=\$$index
    echo "
      set -add window csvcount 5
      evaluate-commands -itersel -draft %{
        execute-keys s<ret>n
        set-option -add window csv_colour_col \"%val{selection_desc}|blue\"
      }
      evaluate-commands -itersel -draft %{
        try %{
          column-selection $next_index
        }
      }
    "

  }
}
define-command csv-next-col %{
  set-register / "%opt{csv_columns}"

}


hook global WinSetOption filetype=(csv) %{
  face buffer InlineInformation CurWord
  hook buffer NormalIdle .* %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
  hook buffer InsertChar .* %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
}

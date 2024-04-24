define-command csv-column  %{
  evaluate-commands %{
    set window col_num %sh{
      cursor=$(( $kak_cursor_column  ))
      sed ''$kak_cursor_line'q;d' $kak_bufname | cut -c 1-$cursor  | csvtool width '-'

    }
}
}

declare-option -hidden regex csv_colour_rgx
# declare-option regex csv_columns (?:,|^)("(?:(?:"")*[^"]*)*"|[^",\n]*|(?:\n|$))
declare-option regex csv_columns (?:\n|,|^)("(?:(?:"")*[^"]*)*"|[^",]*|(?:\n|$))
declare-option regex csv_columns_rgx (?:\\n|,|^)("(?:(?:"")*[^"]*)*"|[^",\\n]*|(?:\\n|$))
declare-option int-list csvcount
declare-option int csv_width

declare-option regex col_rgx
declare-option str-list col_faces

declare-option str-list column_faces "red" "green" "blue" "green" "blue"


define-command -docstring "Colour the columns of the csv" csv-colour %{
  set-option window csv_colour_col "%val{timestamp}"
  try %{
    add-highlighter window/ ranges csv_colour_col
  }
  evaluate-commands -save-regs '/' -draft %{
    set-register / "%opt{csv_columns}"
    execute-keys \%<a-s>
  }
}
define-command csv-uncolour %{
  rmhl window/csv-colour-columns
}
define-command csv-colour-rgx %{
  set window csv_width %sh{
    csvtool width $kak_bufname
  }
  evaluate-commands  %sh{
    index=$#
    eval "set -- $kak_quoted_opt_column_faces"
    length=$#
    columns=$kak_opt_csv_width
    rgx=""
    faces=""
    while [ $index -le $columns ]
    do
      face_index=$(( (index + 1) % length ))
      eval face=\$$face_index
      rgx="${rgx}(?<col${index}>${kak_opt_csv_columns_rgx})"
      faces="${faces} col${index}:${face}"
      index=$(( $index + 1))
    done
    echo "
      set window col_rgx $rgx
      set window col_faces $faces
    "
  }
}

# define-command -hidden column-selection -params 1 %{
#   evaluate-commands %sh{
#     index=$1
#     eval "set -- $kak_quoted_opt_column_faces"
#     length=$#
#     face_index=$(( (index) % (length - 1) ))
#     eval face=\$$face_index 
#     echo "
#       evaluate-commands -itersel -draft %{
#         execute-keys \)
#         set-option -add window csv_colour_col \"%val{selection_desc}|$face\"
#       }
#       evaluate-commands -itersel -draft %{
#         try %{
#           column-selection $(( (index + 1) ))
#         }
#       }
#     "

#   }
# }

define-command csv-next-col %{
  set-register / "%opt{csv_columns}"

}


hook global WinSetOption filetype=(csv) %{
  eval %{
    csv-disable
    csv-colour-rgx
  }
  hook buffer NormalIdle .* %{
    try %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
  }
  hook buffer InsertChar .* %{
    try %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
  }
  hook buffer InsertMove .* %{
    try %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
  }
}

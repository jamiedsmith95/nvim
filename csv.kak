define-command csv-column  %{
  evaluate-commands %{
    try %{
    set window col_num %sh{
      cursor=$(( $kak_cursor_column  ))
      if [ $cursor -gt 1 ]
      then
        cursor=$(( cursor))
      fi
      sed ''$kak_cursor_line'q;d' $kak_bufname | cut -c 1-$cursor  | csvtool width '-'


     }
    } catch %{
    set window col_num %sh{
      cursor=$(( $kak_cursor_column  ))
      if [ $cursor -gt 1 ]
      then
        cursor=$(( cursor))
      fi
      sed ''$kak_cursor_line'q;d' $kak_bufname | cut -c 1-$cursor |  sed 's/.*/&"/' | csvtool width '-'

    }
        } catch %{
    set window col_num %sh{
      cursor=$(( $kak_cursor_column  ))
      if [ $cursor -gt 1 ]
      then
        cursor=$(( cursor))
      fi
      sed ''$kak_cursor_line'q;d' $kak_bufname | cut -c 1-$cursor |  sed 's/.*/&""/' | csvtool width '-'

    }
    }
}
}




declare-option -hidden regex csv_colour_rgx
declare-option int csvline
declare-option int csv_width

declare-option regex csv_columns (?<=[,^\n])(("[^\n]+?")|([^,\n"]*))?(?=[$,\n])

# declare-option regex csv_columns (?:,|^)\K(("(?:(?:"")+?[^"\n]*)+?"|[^",\n]+)|(?:$|\n|,))
declare-option regex csv_columns_rgx ([^",\\n]*){1}|(?:['"[{]+[^\\n]+?['"[{]) # works on the test kaggle

declare-option regex col_rgx
declare-option str-list col_faces

declare-option str-list column_faces "red" "green" "blue" "magenta" "yellow"

define-command -docstring "Swap column with next column" col-swap-forward %{
  evaluate-commands %{
    try %{
      evaluate-commands %sh{
        if[ $kak_opt_col_num -ge $kak_opt_csv_width ]
        then
          echo 1
        fi

      }
    evaluate-commands -itersel %{
    execute-keys N<a-)>,
    }
  } 
  }
}

define-command -docstring "Extend column highlight" col-extend %{
  evaluate-commands %{
    try %{
      evaluate-commands %sh{
        if[ $kak_opt_col_num -le $kak_opt_csv_width ]
        then
          echo 1
        fi
      }
  evaluate-commands -itersel %{
    execute-keys N
  }
}
  }}

define-command -docstring "Extend column highlight back" col-extend-back %{
  evaluate-commands %{
    try %{
      evaluate-commands %sh{
        if[ $kak_opt_col_num -le $kak_opt_csv_width ]
        then
          echo 1
        fi
      }
  evaluate-commands -itersel %{
    execute-keys <a-N>
  }
}
  }}
define-command -docstring "Swap column with previous column" col-swap-back %{
  evaluate-commands %{
    try %{
      evaluate-commands %sh{
        if[ $kak_opt_col_num -le $kak_opt_csv_width ]
        then
          echo 1
        fi
      }
  evaluate-commands -itersel %{
    execute-keys <a-N><a-(>,
  }
}
  }}
define-command -docstring "Select current column" col-select %{
  csv-next-col
  set buffer csvline %val{cursor_line}
  execute-keys \%<a-s><home>
  evaluate-commands -itersel -no-hooks %{
    execute-keys %opt{col_num}n
  }
  execute-keys %opt{csvline})
}

define-command csv-uncolour %{
  rmhl window/csv-colour-columns
}
define-command csv-colour-rgx %{
  set window csv_width %sh{
    csvtool width $kak_bufname
  }
  evaluate-commands  %sh{
    index=1
    eval "set -- $kak_quoted_opt_column_faces"
    columns=$kak_opt_csv_width
    length=$#
    rgx=""
    faces=""
    while [ $index -le $columns ]
    do
      face_index=$(( (index - 1) % (length) ))
      face_index=$(( face_index + 1 ))
      eval face=\$$face_index
      rgx="${rgx}(?<col${index}>${kak_opt_csv_columns_rgx}),"
      faces="${faces} col${index}:${face}"
      index=$(( $index + 1))
    done
    echo "
      set window col_rgx ^$rgx?\$
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
    csv-colour-rgx
  }
    # add-highlighter -override window/csv regex %opt{col_rgx} %opt{col_faces} 
  hook buffer NormalIdle .* %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
  hook buffer InsertChar .* %{
    eval %{
    csv-colour-rgx
    }
    add-highlighter -override window/csv regex %opt{col_rgx} %opt{col_faces} 
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
  hook buffer InsertMove .* %{
    csv-column
  info -style above -anchor "%val{cursor_line}.%val{cursor_column}" %sh{
    csvtool col $(( $kak_opt_col_num )) $kak_buffile | head -1
  }
  }
}


map global normal <a-z> <a-x>
define-command csv-column  %{
  evaluate-commands %{
    set window col_num %sh{
      sed ''$kak_cursor_line'q;d' $kak_bufname | cut -c 1-$kak_cursor_column | csvtool width '-'
    }
}
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

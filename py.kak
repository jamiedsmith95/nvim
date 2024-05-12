declare-option range-specs indent_ranges %val{timestamp}
declare-option -hidden regex indent_reg (?<=:[\n])\h{4}(?=[\w])
declare-option str-list indent_str
declare-option -hidden regex indent_reg2 (?<=:[\n])\h{8}(?=[\w])
declare-option -hidden regex indent_start2 ^\h{4}\w.+?:\n
declare-option -hidden regex indent_reg3 (?<=:[\n])\h{12}(?=[\w])
declare-option -hidden regex indent_search1 (^$\n)+(?=[\w])
declare-option -hidden regex indent_search2 ^\h{4}(?=[\w])
declare-option -hidden regex indent_search3 ^\h{8}(?=[\w])

hook window NormalIdle .* %{
  remove-highlighter  window/inrange
  evaluate-commands -draft -save-regs '/' get-indent
  add-highlighter window/inrange replace-ranges indent_ranges
}



define-command -docstring "get indentations" get-indent %{
  evaluate-commands -draft %{
    set-option window indent_ranges %val{timestamp}
    set-option window indent_str 
    set-register slash %opt{indent_start2}
    try %{
      execute-keys <a-/><up><ret>x?(^\h{4}\H|^$)<ret><a-s>s^\h{8,}(?=[\H])<ret>
      set-register slash %opt{indent_reg2}
        execute-keys -itersel ghL
      evaluate-commands -itersel %{
        set-option -add window indent_str "%val{selection_desc}|{green}║{blue}║"
      }
    }

     set-register slash %opt{indent_search1}
     try %{
       execute-keys ?<up><ret>s^\h{4}(?=[\H])<ret><a-s>
         execute-keys -itersel gh
       evaluate-commands -itersel %{
         set-option -add window indent_str "%val{selection_desc}|{green}║"
       }
     }
    set-register slash %opt{indent_reg}
    try %{
    execute-keys \%s<up><ret>
     evaluate-commands -itersel %{
       set-option -add window indent_str  "%val{selection_desc}|{green}╔══▷"
   }
    }

   #  set-register slash %opt{indent_reg2}
   #  try %{
   #  execute-keys \%s<up><ret>
   #   evaluate-commands -itersel %{
   #     set-option -add window indent_str  "%val{selection_desc}|{green}║{blue}╔═════▷"
   # }
   #   set-register slash %opt{indent_search2}
   #   try %{
   #     execute-keys \?<up><ret>s^\h\h<ret><a-s>
   #     evaluate-commands -itersel %{
   #       set-option -add window indent_str "%val{selection_desc}|{green}║{blue}║"
   #     }
   #   }
   #  }
   #  try %{
   #  set-register slash %opt{indent_reg3}
   #  execute-keys \%s<up><ret>
   #   evaluate-commands -itersel %{
   #     set-option -add window indent_str  "%val{selection_desc}|{green}║{blue}║{red}╔════════▷"
   #   }
   #   set-register slash %opt{indent_search3}
   #   try %{
   #     execute-keys \?<up><ret>s^\h\h\h<ret><a-s>
   #     evaluate-commands -itersel %{
   #       set-option -add window indent_str "%val{selection_desc}|{green}║{blue}║{red}║"
   #     }
   #   }
   #  }
   set-option window indent_ranges %val{timestamp} %opt{indent_str}

  }


 }

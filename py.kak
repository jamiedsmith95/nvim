declare-option range-specs indent_ranges1 %val{timestamp}
declare-option range-specs indent_ranges2 %val{timestamp}
declare-option range-specs indent_ranges3 %val{timestamp}
declare-option -hidden regex indent_reg (?<=:[\n])\h{4}(?=[\w])
declare-option str-list indent_str1
declare-option str-list indent_str2
declare-option str-list indent_str3
declare-option -hidden regex indent_reg2 (?S)^\h{4}\w.+?:$
declare-option -hidden regex indent_start2 (?S)^\h{4}\w.+?:$
declare-option -hidden regex indent_reg3 (?<=:[\n])\h{12}(?=[\w])
declare-option -hidden regex indent_search1 (^$\n)+(?=[\w])
declare-option -hidden regex indent_search2 ^\h{4}(?=[\w])
declare-option -hidden regex indent_search3 ^\h{8}(?=[\w])

hook window NormalIdle .* %{
  # remove-highlighter  window/inrange1
  # remove-highlighter  window/inrange2
  # remove-highlighter  window/inrange3
  evaluate-commands -draft -save-regs '/' get-indent

  add-highlighter -override window/inrange1 replace-ranges indent_ranges1
  add-highlighter -override window/inrange2 replace-ranges indent_ranges2
  add-highlighter -override window/inrange3 replace-ranges indent_ranges3
}



define-command -docstring "get indentations" get-indent %{
  evaluate-commands -draft %{
    set-option window indent_ranges1 %val{timestamp}
    set-option window indent_ranges1 %val{timestamp}
    set-option window indent_ranges1 %val{timestamp}
    set-option window indent_str1 
    set-option window indent_str2 
    set-option window indent_str3
    set-register slash %opt{indent_reg2}
    try %{
      execute-keys \%s<up><ret><a-s>
      execute-keys -itersel ghlLL
      evaluate-commands -itersel %{
      set-option -add window indent_str2 "%val{selection_desc}|{blue+d}╔═▷"
      }
      evaluate-commands -itersel %{
      execute-keys  ghjgh]i<a-s>
      execute-keys -itersel ghl
      }

      evaluate-commands -itersel %{
        set-option -add window indent_str2 "%val{selection_desc}|{blue+d}║"
      }
      
      


    }

    set-register slash %opt{indent_reg}
    try %{
    execute-keys \%s<up><ret>
     evaluate-commands -itersel %{
       set-option -add window indent_str1  "%val{selection_desc}|{green+d}╔══▷"
   }
    }

     try %{
       # execute-keys ?<up><ret>s^\h{4}(?=[\H])<ret><a-s>
       execute-keys -itersel ]i<ret>X<a-s>
         execute-keys -itersel gh
       evaluate-commands -itersel %{
         set-option -add window indent_str1 "%val{selection_desc}|{green+d}║"
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
   set-option window indent_ranges1 %val{timestamp} %opt{indent_str1}
   set-option window indent_ranges2 %val{timestamp} %opt{indent_str2}
   set-option window indent_ranges3 %val{timestamp} %opt{indent_str3}

  }


 }

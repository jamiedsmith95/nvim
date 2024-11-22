declare-option range-specs indent_ranges1 %val{timestamp}
declare-option range-specs indent_ranges2 %val{timestamp}
declare-option range-specs indent_ranges3 %val{timestamp}
declare-option str-list indent_str1
declare-option str-list indent_str2
declare-option str-list indent_str3
declare-option str myred 'red+d'
declare-option int mycursor
declare-option int int1
declare-option int int2
# declare-option -hidden regex indent_reg (?S)^\H.+:$
declare-option -hidden regex indent_reg (?s)^\w[^\n]+?:$
declare-option -hidden regex indent_reg2 (?s)^\h{4}\w.+?:$
declare-option -hidden regex indent_start2 (?S)^\h{4}\H.+:$
declare-option -hidden regex indent_reg3 (?s)^\h{8}\w.+?:$
 declare-option str context

hook window NormalIdle .* %{
  # remove-highlighter  window/inrange1
  # remove-highlighter  window/inrange2
  # remove-highlighter  window/inrange3
  # evaluate-commands -draft -save-regs '/' get-indent

  # add-highlighter -override window/inrange1 replace-ranges indent_ranges1
  # add-highlighter -override window/inrange2 replace-ranges indent_ranges2
  # add-highlighter -override window/inrange3 replace-ranges indent_ranges3



  # info context
  info -style menu
  set window context ''
  evaluate-commands -draft -save-regs '/' hover-context
  info -style menu %opt{context}
}



define-command -docstring "get indentations" get-indent %{
  evaluate-commands -draft %{
    set-option window indent_ranges1 %val{timestamp}
    set-option window indent_ranges1 %val{timestamp}
    set-option window indent_ranges1 %val{timestamp}
    set-option window indent_str1 
    set-option window indent_str2 
    set-option window indent_str3
    set-option window mycursor %val{cursor_line}

    # select 3rd indentations
    set-register slash %opt{indent_reg3}

    # try %{
      # execute-keys \%s<up><ret>
      # execute-keys -itersel ghllGiH
      # evaluate-commands -itersel %{
      #   set-option -add window indent_str3 "%val{selection_desc}|{red+d}╔════▷"
      #   execute-keys  ghjgh]i<a-s><a-,>
      #   execute-keys -itersel ghll
      # }
      try %{
      execute-keys \%s<up><ret>
      evaluate-commands -itersel -draft -save-regs '/' %{

      set-option window int1 %val{cursor_line}
      execute-keys jgh]i\;
      set-option window int2 %val{cursor_line}

        evaluate-commands -draft %sh{
          red="red+d"
          if [ $kak_opt_int1 -le $kak_opt_mycursor -a $kak_opt_int2 -ge $kak_opt_mycursor ]
          then
            red="red"
          fi
          echo "
          set window myred $red"
        }
      execute-keys <a-n>ghllGiH


        set-option -add window indent_str3 "%val{selection_desc}|{%opt{myred}}╔════▷"
        execute-keys  ghjgh]iX<a-s><a-,>
        execute-keys -itersel ghll
      
      evaluate-commands -itersel %{
        set-option -add window indent_str3 "%val{selection_desc}|{%opt{myred}}║"
      }
      execute-keys ,\%s<up><ret>
      execute-keys -itersel jgh]i<a-x><a-s><a-K>^$<ret>ghll
      evaluate-commands -itersel %{
        set-option -add window indent_str3 "%val{selection_desc}|{%opt{myred}}╚"
      }
      execute-keys lGiHHs.<ret>
      evaluate-commands -itersel %{
        set-option -add window indent_str3 "%val{selection_desc}|{%opt{myred}}═"
      }
      execute-keys gih<a-+>
      evaluate-commands -itersel %{
      set-option -add window indent_str3 "%val{selection_desc}|{%opt{myred}}X"
      }
      }
      }
    # }
    # try %{
    #   execute-keys \"cz<a-s>
    #   evaluate-commands -itersel %{
    #     set-option -remove window indent_str3 "%val{selection_desc}|{red+d}╔════▷"
    #     set-option -add window indent_str3 "%val{selection_desc}|{red}╔════▷"
    #     execute-keys  ghjgh]i<a-s><a-,>
    #     execute-keys -itersel ghll
    #   }
    #   evaluate-commands -itersel %{
    #     set-option -remove window indent_str3 "%val{selection_desc}|{red+d}║"
    #     set-option -add window indent_str3 "%val{selection_desc}|{red}║"
    #   }
    #   execute-keys \%s<up><ret>
    #   execute-keys -itersel j]ighll
    #   evaluate-commands -itersel %{
    #     set-option -remove window indent_str3 "%val{selection_desc}|{red+d}╚"
    #     set-option -add window indent_str3 "%val{selection_desc}|{red}╚"
    #   }
    #   execute-keys lGiHHs.<ret>
    #   evaluate-commands -itersel %{
    #     set-option -remove window indent_str3 "%val{selection_desc}|{red+d}═"
    #     set-option -add window indent_str3 "%val{selection_desc}|{red}═"
    #   }
    #   execute-keys gih
    #   evaluate-commands -itersel %{
    #   set-option -remove window indent_str3 "%val{selection_desc}|{red+d}X"
    #   set-option -add window indent_str3 "%val{selection_desc}|{red}X"
    #   }
    # }


    set-register slash %opt{indent_reg2}
    try %{
      execute-keys <a-n>j]i"bZ
      execute-keys \%s<up><ret><a-s>
      execute-keys -itersel ghlLL
      evaluate-commands -itersel %{

      set-option -add window indent_str2 "%val{selection_desc}|{blue+d}╔═▷"
      
      evaluate-commands -itersel %{
      execute-keys  ghjgh]i<a-s><a-,>
      execute-keys -itersel ghl
      }

      evaluate-commands -itersel %{
        set-option -add window indent_str2 "%val{selection_desc}|{blue+d}║"
      }
      
      execute-keys \%s<up><ret>
      execute-keys -itersel j]ighl
      evaluate-commands -itersel %{
        set-option -add window indent_str2 "%val{selection_desc}|{blue+d}╚"
      }
      execute-keys lGiHHs.<ret>
      evaluate-commands -itersel %{
        set-option -add window indent_str2 "%val{selection_desc}|{blue+d}═"
      }
      execute-keys gih
      evaluate-commands -itersel %{
      set-option -add window indent_str2 "%val{selection_desc}|{blue+d}X"
      }
      
    }
    }

    set-register slash %opt{indent_reg}
    try %{
    execute-keys \%s<up><ret>
    execute-keys -itersel jgh
     evaluate-commands -itersel %{
       set-option -add window indent_str1  "%val{selection_desc}|{green+d}▲"
   }
    }

     try %{
       execute-keys -itersel gh]i<a-s><a-,>)<a-,>Z<a-K>^$<ret>
         execute-keys -itersel gh
       evaluate-commands -itersel %{
         set-option -add window indent_str1 "%val{selection_desc}|{green+d}║"
       }
       execute-keys z<a-k>^$<ret>
       evaluate-commands -itersel %{
         set-option -add window indent_str1 "%val{selection_desc}|{green+d}O"
       }
      execute-keys \%s<up><ret>
      execute-keys -itersel j]ighk<a-s>
      evaluate-commands -itersel %{
        set-option -add window indent_str1 "%val{selection_desc}|{green+d}▼"
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
 declare-option str context
 define-command -docstring "Context box showing current function context" hover-context %{
   try %{
     evaluate-commands -save-regs '/' %{
     execute-keys \"cZ
     set-register slash %opt{indent_reg}
   execute-keys Ggs<up><ret>,<a-\;>x
   set -add window context %val{selection}
     }


    try %{
     evaluate-commands -save-regs '/' %{
     set-register slash %opt{indent_reg2}
     execute-keys \"c<a-z>uxs<up><ret>,"dZx
     echo -debug %val{selection}
   set -add window context %val{selection}
     }

   #  try %{
   #   set-register slash %opt{indent_reg3}
   #   execute-keys \"d<a-z>uxs<up><ret>,x
   #   echo -debug %val{selection}
   # set -add window context %val{selection}
   #  }
    }
   
   # execute-keys  gh[ik\;xy
   # set -add window context %val{selection}
   # execute-keys  gh[ik\;xy
   # set -add window context %val{selection}
   }

 }

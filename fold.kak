declare-option -docstring 'Option holding ranges to fold over' range-specs fold_ranges

define-command -docstring 'Set current main selection to fold-ranges' fold-selection %{
    set buffer fold_ranges %val{timestamp} "%val{selection_desc}|{red}--FOLD--"
    add-highlighter -override buffer/ replace-ranges fold_ranges
}

define-command -docstring 'Add main selection to fold-ranges' fold-add-selection %{
    set -add buffer fold_ranges "%val{selection_desc}|{red}--FOLD--"
    add-highlighter -override buffer/ replace-ranges fold_ranges
}

define-command -docstring 'Add main selection to fold-ranges' fold-remove-selection %{
    set -remove buffer fold_ranges "%val{selection_desc}|{red}--FOLD--"
}
map -docstring 'Fold selection' global user z ':fold-add-selection<ret>'
map -docstring 'Unfold selection' global user Z ':fold-remove-selection<ret>'
map -docstring 'Set selection as only fold' global user <a-z> ':fold-selection<ret>'

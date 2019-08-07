setlocal shiftwidth=2
setlocal softtabstop=2

let g:vimtex_complete_close_braces = 1
let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_autoclose_after_keystrokes = 7

let b:surround_{char2nr('e')} = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"
let b:surround_{char2nr('"')} = "``\r''"

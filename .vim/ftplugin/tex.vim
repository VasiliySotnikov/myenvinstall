set sw=2
let g:tex_flavor='pdflatex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_UseMakefile=0
let g:Tex_GotoError=0
let g:Tex_ViewRule_pdf = 'okular --unique'
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal iskeyword+=:

map <leader>la :w<CR><leader>ll<leader>lv
"map <leader>fr o\begin{frame}[<++>]<CR>\frametitle{<++>}<CR><++><CR>\end{frame}<CR><++><ESC>`[<C-j>

let g:Tex_Env_frame = "\\begin{frame}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}\<CR><++>"
call IMAP('EFR', g:Tex_Env_frame,'tex')

let g:Tex_Env_block = "\\begin{block}{<++>}\<CR><++>\<CR>\\end{block}\<CR><++>"
call IMAP('EBL', g:Tex_Env_block,'tex')

let g:Tex_Env_column = "\\begin{column}{<++>\\textwidth}\<CR><++>\<CR>\\end{column}\<CR><++>"
call IMAP('ECO', g:Tex_Env_column,'tex')

let g:Tex_Env_multline = "\\begin{multline}\<CR><++>\<CR>\\end{multline}\<CR><++>"
call IMAP('EML', g:Tex_Env_multline,'tex')

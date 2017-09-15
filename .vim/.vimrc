set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

syntax on
syntax enable

autocmd! BufRead,BufNewFile *.dat     setfiletype sh

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jacquesbh/vim-showmarks'
Plugin 'grep.vim'
Plugin 'tpope/vim-fugitive.git'
call vundle#end()

"this is a fix for the bug with highlighting in c preprocessor macros
"hi link cCppOut2 PreProc

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:tex_flavor='latex'

if has("gui_running")
    set background=light
    nmap <Esc> :q<CR>
    nnoremap <C-tab> :tabn<CR>
    nnoremap <C-S-tab> :tabp<CR>
    inoremap <C-tab> <ESC>:tabn<CR>li
    inoremap <C-S-tab> <ESC>:tabp<CR>li
    nnoremap <silent><A-S-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><A-S-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
else
    set background=dark
    nnoremap <F7> :tabp<CR>
    nnoremap <F8> :tabn<CR>
    nnoremap <C-Down> mpo<Esc>`p
    nnoremap <C-Up> mpO<Esc>`p
endif

colorscheme solarized 

set wildmenu
set showcmd

set backspace=indent,eol,start
set autoindent

set ruler
set laststatus=2

set confirm

set visualbell

set cmdheight=2
set number
set hlsearch

set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set showmatch

set foldcolumn=1

"helptags ~/.vim/doc


function! ToggleModifiable()
    if &modifiable
        set nomodifiable
        echo "nomodifiable is set"
    else
        set modifiable
        echo "modifiable is set"
    endif
endfunction


let g:show_marks = 0

function! ToggleShowMarks()
    if g:show_marks == 0
        DoShowMarks!
        let g:show_marks = 1
        echo "showing marks"
    else
        NoShowMarks!
        let g:show_marks = 0
        echo "not showing marks"
    endif
endfunction


let mapleader="\<Space>"

"Tab navigation:
nnoremap <tab> <C-w>w
"Move tabs at the tab panel
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
nnoremap <leader>tt <CR>:tab drop 

map <silent> <F3> :call ToggleShowMarks()<CR>
map <F9> :wa<CR>:mksession! ~/.vim/blackhat_session.vim <CR>
map <F10> :w<CR>
map <leader>m :call ToggleModifiable()<CR>

inoremap jk <Esc>
vnoremap ;; <Esc>
inoremap {<CR> {<CR>}<c-o>O

" Vim-latex corrupts this for some reason
unmap <C-i>

"Some grep recipes:
nnoremap <F4> /<c-r>=expand("<cword>")<CR><CR>N:Grep -r --exclude="tags" <cword> *<CR> <c-w>T
nnoremap <F5> :Grep -r --exclude="tags"<CR>
"Launch make in pwd and show quickfix window with errors (if any):
nnoremap <F6> :w<CR>:make -j1<CR>:copen<CR> 

set winaltkeys=no

set shortmess+=c
set guioptions-=e
set sessionoptions+=tabpages,globals

set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

syntax on
syntax enable

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jacquesbh/vim-showmarks'
Plugin 'grep.vim'
call vundle#end()

"this is a fix for the bug with highlighting in c preprocessor macros
hi link cCppOut2 PreProc

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:tex_flavor='latex'

if has("gui_running")
    set background=light
    nmap <Esc> :q<CR>
else
    set background=dark
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

map <silent> <F3> :call ToggleShowMarks()<CR>

let mapleader="\<Space>"
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
map <F7> :tabp<CR>
map <F8> :tabn<CR>
map <F2> :!ls<CR>:tab drop 
map <F9> :wa<CR>:mksession! ~/.vim/blackhat_session.vim <CR>
map <F10> :w<CR>
map <leader>m :call ToggleModifiable()<CR>
inoremap jk <Esc>
vnoremap ;; <Esc>
nnoremap <C-J> mpo<Esc>`p
nnoremap <C-K> mpO<Esc>`p
inoremap {<CR> {<CR>}<c-o>O
nnoremap <F4> /<c-r>=expand("<cword>")<CR><CR>N:Grep -r --exclude="*Darren*worker*" --exclude="cut_part_worker*" --exclude="tags" <cword> *<CR> <c-w>T
nnoremap <F5> :Grep -r --exclude="*Darren*worker*" --exclude="cut_part_worker*" --exclude="tags"<CR>
nnoremap <F6> :w<CR>:make -j5 \| cwindow 20<CR>

set shortmess+=c

set guioptions-=e
set sessionoptions+=tabpages,globals

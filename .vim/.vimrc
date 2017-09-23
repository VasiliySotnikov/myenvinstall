set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

syntax on
syntax enable

" Highlight stuff in *.dat files as in shell script
autocmd! BufRead,BufNewFile *.dat     setfiletype sh

set history=1000

" Load plugins
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
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'terryma/vim-expand-region'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
call vundle#end()

"this is a fix for the bug with highlighting in c preprocessor macros (looks to be fixed in a new version)
"hi link cCppOut2 PreProc

" Options for ycm
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let mapleader="\<Space>"

if has("gui_running")
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
endif


colorscheme solarized

" Remove and add empty lines
if has("gui_running")
    set background=light
    set lines=75
    set columns=999
    nnoremap <silent><A-S-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><A-S-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
else
    set background=dark
    nnoremap <silent><K> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><K> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent>k :set paste<CR>m`O<Esc>``:set nopaste<CR>
    nnoremap <silent>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
endif

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

" Tab navigation:
nnoremap <leader>tt :tab drop<space>
if has("gui_running")
    nnoremap <silent> <A-Left> :-tabmove<CR>
    nnoremap <silent> <A-Right> :+tabmove<CR>
    nnoremap <C-tab> :tabn<CR>
    nnoremap <C-S-tab> :tabp<CR>
    inoremap <C-tab> <ESC>:tabn<CR>li
    inoremap <C-S-tab> <ESC>:tabp<CR>li
else
    nnoremap <silent> [1;3D :-tabmove<CR>
    nnoremap <silent> [1;3C :+tabmove<CR>
    nnoremap <F7> :tabp<CR>
    nnoremap <F8> :tabn<CR>
    inoremap <F7> <ESC>:tabp<CR>li
    inoremap <F8> <ESC>:tabn<CR>li
endif

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
map <F9> :wa<CR>:mksession! ~/.vim/blackhat_session.vim <CR>
map <leader>m :call ToggleModifiable()<CR>

nnoremap <leader>w :w<CR>
inoremap jk <Esc>
vnoremap ;; <Esc>
inoremap {<CR> {<CR>}<c-o>O

"Some grep recipes:
nnoremap <F4> /<c-r>=expand("<cword>")<CR><CR>N:Grep -r --exclude="tags" <cword> *<CR> <c-w>T
nnoremap <F5> :Grep -r --exclude="tags"<CR>
"Launch make in pwd and show quickfix window with errors (if any):
nnoremap <F6> :w<CR>:make -j1<CR>:copen<CR>

set winaltkeys=no

set shortmess+=c
set guioptions-=e
set sessionoptions+=tabpages,globals

let g:session_autosave = "no"

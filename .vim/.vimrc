set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

syntax on
syntax enable

" Highlight stuff in *.dat files as in shell script
autocmd! BufRead,BufNewFile *.dat     setfiletype sh

" Automatically set spell for commit messages
autocmd! BufRead,BufNewFile COMMIT_EDITMSG setlocal spell

let $PATH = $HOME.'/local/bin/:'.$PATH

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
Plugin 'rhysd/vim-clang-format'
"Plugin 'craigemery/vim-autotag'
Plugin 'CoatiSoftware/vim-sourcetrail'
call vundle#end()

"this is a fix for the bug with highlighting in c preprocessor macros (looks to be fixed in a new version)
"hi link cCppOut2 PreProc

" Options for ycm
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_complete_in_comments=1
set completeopt-=preview
"let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_max_diagnostics_to_display = 100

let g:ycm_filetype_whitelist = { 'cpp': 1 }

let mapleader="\<Space>"

if has("gui_running")
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
endif

" vim-session settings
let g:session_autoload='no'
let g:session_autosave_periodic=5
let g:session_autosave_silent=1
let g:session_default_to_last=1
let g:session_persist_font = 0
let g:session_persist_colors = 0

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
    nnoremap <silent><J> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><K> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent>k :set paste<CR>m`O<Esc>``:set nopaste<CR>
    nnoremap <silent>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
endif

set wildmenu
set showcmd

set backspace=indent,eol,start
set autoindent

set noswapfile
set undofile " Maintain undo history between sessions
set undodir=~/tmp

set ruler
set laststatus=2

set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

set confirm

set visualbell

set cmdheight=2
set number

set incsearch
set hlsearch

set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set showmatch

set scrolloff=5

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
nnoremap <leader>m :call ToggleModifiable()<CR>

"useful fugitive mappings
nnoremap <leader>gs :Gstatus<CR><C-W>T:-tabmove<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog -10 -- %<CR><CR>:copen<CR><C-W>k
nnoremap <leader>gpu :Gpush<CR>

nnoremap <leader>= :ClangFormat<CR>
vnoremap == :ClangFormat<CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <leader>w :w<CR>
inoremap jk <Esc>
vnoremap ;; <Esc>
inoremap {<CR> {<CR>}<c-o>O

"Some grep recipes:
nnoremap <F4> /<c-r>=expand("<cword>")<CR><CR>N:Grep -r --exclude="tags" --exclude-dir="build*" \<<cword>\> *<CR> <c-w>T
nnoremap <leader>ss :Grep -r --exclude="tags" --exclude-dir="build*"<CR>
"Launch make in pwd and show quickfix window with errors (if any):
nnoremap <F6> :w<CR>:make <CR>:copen<CR>

set winaltkeys=no

set shortmess+=c
set guioptions-=e
set sessionoptions+=tabpages,globals

set spelllang=en_us

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

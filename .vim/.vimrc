set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

syntax on
syntax enable

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
"Plugin 'rdnetto/YCM-Generator'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jacquesbh/vim-showmarks'
Plugin 'grep.vim'
Plugin 'tpope/vim-fugitive.git'
Plugin 'shumphrey/fugitive-gitlab.vim'
Plugin 'rbong/vim-flog'
"Plugin 'ntpeters/vim-better-whitespace'
Plugin 'terryma/vim-expand-region'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'CoatiSoftware/vim-sourcetrail'
Plugin 'VasiliySotnikov/vim-mathematica'
Plugin 'lervag/vimtex'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-obsession'

Plugin 'dhruvasagar/vim-open-url'
call vundle#end()

let mapleader="\<Space>"

" Options for ycm
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_complete_in_comments=1
set completeopt-=preview
"let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_max_diagnostics_to_display = 100

let g:ycm_filetype_whitelist = { 'cpp': 1 , 'python': 1 }

nmap <leader>doc <plug>(YCMHover)

if has("gui_running")
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
endif

" vim-session settings
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_autosave_periodic=5
let g:session_autosave_silent=1
let g:session_default_to_last=1
let g:session_persist_font = 0
let g:session_persist_colors = 0

let g:gutentags_exclude_filetypes = ['mma']

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
    set background=light
    nnoremap <silent><J> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent><K> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
    nnoremap <silent>k :set paste<CR>m`O<Esc>``:set nopaste<CR>
    nnoremap <silent>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
endif

set wildmode=longest,list,full
set wildmenu
set showcmd

set backspace=indent,eol,start
set autoindent

set noswapfile
set undofile " Maintain undo history between sessions
set undodir=~/tmp

set ruler
set laststatus=2

set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%{ObsessionStatus()}%=%-14.(%l,%c%V%)\ %P

set confirm

set visualbell

set cmdheight=2
set number

set incsearch
set hlsearch
set smartcase

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
else
    nnoremap <silent> [1;3D :-tabmove<CR>
    nnoremap <silent> [1;3C :+tabmove<CR>
endif
nnoremap H gT
nnoremap L gt
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

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

nnoremap <leader>jj i<CR><ESC>


"useful fugitive mappings
nnoremap <leader>gs :Gstatus<CR><C-W>T:-tabmove<CR>
nnoremap <leader>gfl :Flog<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gl :Glog -10 -- %<CR><CR>:copen<CR><C-W>k
nnoremap <leader>gpu :G push<CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nnoremap <leader>w :w<CR>
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap ;; <Esc>
inoremap {<CR> {<CR>}<c-o>O

imap <F1> <nop>
inoremap <F1> <Backspace>

"Some grep recipes:
nnoremap <F4> /<c-r>=expand("<cword>")<CR><CR>N:Grep -r --exclude="tags" --exclude-dir="build*" \<<cword>\> *<CR> <c-w>T
nnoremap <leader>ss :Grep -r --exclude="tags" --exclude-dir="build*"<CR>
"Launch make in pwd and show quickfix window with errors (if any):
nnoremap <F6> :w<CR>:make <CR>:copen<CR>
"The will be usefull most of the time
set makeprg=cd\ ../build;\ ninja\ -j4

set winaltkeys=no

set shortmess+=c
set guioptions-=e
set sessionoptions+=tabpages,globals

set spelllang=en_us

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

let g:mma_highlight_option = "solarized"


" Close all tabls to the right of the current one
command! -nargs=0 TabCloseRight :.+1,$tabdo :tabclose


" UltiSnips settings
let g:UltiSnipsExpandTrigger = '<A-q>'
let g:UltiSnipsJumpForwardTrigger = '<A-j>'
let g:UltiSnipsJumpBackwardTrigger = '<A-k>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

inoremap <A-u> <ESC>ua


nnoremap <leader>tr :NERDTree %<CR>

" Gitlab plugin settings
let g:gitlab_api_keys = {'gitlab.com': '5KPkdwYUJ_ysChX4_rxL'}

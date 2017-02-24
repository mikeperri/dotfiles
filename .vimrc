set nocp
syntax on
filetype plugin indent on
set pastetoggle=<F1>

" Don't write extra files
set noswapfile
set nowritebackup

" Always show status line
set laststatus=2

" File format
set ff=unix
set encoding=utf8

" Always show sign column (points to lines with errors)
set signcolumn=yes

" Leader key
let mapleader=" "

" Appearance
set t_Co=256
set background=dark

if has("gui_running")
    winpos 100 100
    set lines=30
    set columns=140
    set guioptions=Ace
    autocmd GUIEnter * set vb t_vb=

    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

" Tab characters
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set smarttab
set backspace=2

" Wild
set wildmenu
set wildmode=longest,list
set wildignore+=node_modules
set wildignore+=dist/
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=*/dist/*
set wildignore+=*/out/*
set wildignore+=*/pkg/*
set wildignore+=*/node_modules/*
set wildignore+=tags,cscope.*
set wildignore+=*.tar.*
set wildignorecase
set wildmode=list:full
set path=.,**
nnoremap <leader>f :find *
nnoremap <leader>F :find <C-R>=expand('%:p:h').'/**/*'<CR>

" Line numbers
set number
set numberwidth=4

" Find
set ignorecase
set smartcase

" Show whitespace
set list listchars=tab:>-,trail:-
set list

" Search
set incsearch
set hlsearch
nnoremap <leader>/ :nohls<CR>

" Set timeout length
set timeoutlen=300

" Disable bells
set vb t_vb=

" Cut/Copy/Paste
vmap <C-c> "*y
vmap <C-x> "*x
imap <C-v> <ESC>"*pi

" Netrw
let g:netrw_liststyle = 0
let g:netrw_list_hide = '^\.'
let g:netrw_hide = 1

" Format
command! FixWhitespace retab | %s/\s\+$

" Capital letters
command! W w
command! Q q
command! Wq wq

" Mouse
if !has("gui_running")
    set mouse=a
    inoremap <Esc>[62~ <C-X><C-E>
    inoremap <Esc>[63~ <C-X><C-Y>
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
endif

" Grep
set grepprg=grep\ -nR\ $*\ --exclude-dir\ node_modules\ --exclude-dir\ .git

" TextTransform
function! TextTransform()
    if expand("%:e") ==# "tt"
        let currentFilePath = expand("%:p")
        let ttPath = 'C:\Program Files (x86)\Common Files\Microsoft Shared\TextTemplating\14.0\TextTransform.exe'
        let cmd = "\"" . ttPath . "\" " . currentFilePath
        exec ":!" . cmd
    else
        echom "Not a TextTransform file (*.tt)"
    endif
endfunction
command! TextTransform call TextTransform()

" Use forward slash on Windows
let &shellslash=0

" JavaScript
set suffixesadd+=.js

" TypeScript
set suffixesadd+=.ts










" vim-plug
let g:plug_timeout = 100

function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

if has("win32")
    call plug#begin('~/vimfiles/plugged')
else
    call plug#begin('~/vim/plugged')
endif
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-syntastic/syntastic'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'juanpabloaj/vim-pixelmuerto'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/YankRing.vim'
Plug 'mikeperri/YouCompleteMe', { 'branch': 'typescript-diagnostics', 'for': [ 'javascript', 'typescript', 'python', 'vim' ], 'do': 'python install.py' }
call plug#end()

" Theme
if !has("win32") || has("gui_win32")
    colo pixelmuerto
else
    colo elflord
endif

" File/Buffer Navigation
nmap _ :Explore .<CR>
map <C-l> :CtrlPCurFile<CR>
map <C-h> :CtrlPMRU<CR>
map <F9> :Gstatus<CR>
set hidden

" CtrlP
let g:ctrlp_map = '<C-k>'
let g:ctrlp_user_command =
  \ ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.fugitiveblame$',
  \ }

" Airline
let g:airline_section_a = ''
let g:airline_section_b = ''
let g:airline_section_y = ''

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_html_checkers = []
let g:syntastic_javascript_checkers = ['eslint']

" YouCompleteMe
command! -nargs=1 Rename YcmCompleter RefactorRename <args>
nnoremap <F12> :YcmCompleter GoToDefinition<CR>
nnoremap <F11> :YcmCompleter GoToReferences<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>

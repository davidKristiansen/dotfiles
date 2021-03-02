set nocompatible
syntax on

set mouse=a

"set paste

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
"  show existing tab with 2 spaces width
set tabstop=4
set softtabstop=4
" when indenting with '>', use 2 spaces width
set shiftwidth=4

set autoindent

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" turn hybrid line numbers on
" set number relativenumber

" fun! SetRelativeLineNumber()
"   if(exists('t:NERDTreeBufName') && bufname('%') == t:NERDTreeBufName)
"     return
"   end
"   set relativenumber
" endfun

" fun! SetNoRelativeLineNumber()
"   if(exists('t:NERDTreeBufName') && bufname('%') == t:NERDTreeBufName)
"     return
"   end
"   set norelativenumber
" endfun

" augroup numbertoggle
" 	autocmd!
" 	autocmd BufEnter,FocusGained,InsertLeave * call SetRelativeLineNumber()
" 	autocmd BufLeave,FocusLost,InsertEnter   * call SetNoRelativeLineNumber()
" augroup END

set autoread
set backspace=indent,eol,start
set belloff=all
" set complete-=i
" set display=lastline
" set formatoptions=tcqj
set history=10000
set incsearch
set laststatus=2
set ruler
" set sessionoptions-=options
" set showcmd
" set sidescroll=1
set smarttab
" set ttimeoutlen=50
set ttyfast
set viminfo+=!
" set wildmenu

set noshowmode
set splitright
set splitbelow

" Auto remove trailing whitespaces
autocmd BufWritePre *.py :%s/\s\+$//e

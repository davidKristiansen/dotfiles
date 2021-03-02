" call plug#begin(g:nvim_config_root . '/plugged')
call plug#begin()

" Convert between bases
Plug 'glts/vim-radical'
Plug 'tpope/vim-repeat'
Plug 'unblevable/quick-scope'
Plug 'RRethy/vim-illuminate'
Plug 'asvetliakov/vim-easymotion'

if exists('g:vscode')
else
    
    " Display color
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    
    " File explorer
    " Plug 'preservim/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Plug 'scrooloose/nerdtree-project-plugin'
    " Plug 'PhilRunninger/nerdtree-buffer-ops'

    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'

    " Coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    " Comments
    Plug 'b3nj5m1n/kommentary'
    " Plug 'tpope/vim-commentary'

    " Snippets
    Plug 'SirVer/ultisnips'

    " Search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'APZelos/blamer.nvim'

    " 
    Plug 'sainnhe/gruvbox-material'
    
    Plug 'nvim-treesitter/nvim-treesitter'
    
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    " Plug 'hoob3rt/lualine.nvim'

    Plug 'edkolev/tmuxline.vim'
    Plug 'christoomey/vim-tmux-navigator'
    
    Plug 'undu/numbers.vim'
    
    Plug 'junegunn/goyo.vim'
    
    Plug 'mboughaba/i3config.vim'
    
    Plug 'cdelledonne/vim-cmake'

    Plug 'junegunn/vim-peekaboo'

    Plug 'mhinz/vim-startify'

    Plug 'vimwiki/vimwiki'

    endif


call plug#end()



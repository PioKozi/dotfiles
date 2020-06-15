call plug#begin('~/.config/nvim/plugged')

    " For looks
    Plug 'morhetz/gruvbox'    
    Plug 'vim-airline/vim-airline'

    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " filetree
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'xuyuanp/nerdtree-git-plugin'

    " colours
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'luochen1990/rainbow'

    " quality of textediting
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'unblevable/quick-scope'
    Plug 'chaoren/vim-wordmotion'
    Plug 'junegunn/fzf'
    Plug 'jiangmiao/auto-pairs'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " languages + formats (most are in coc.nvim)
    Plug 'plasticboy/vim-markdown'
    Plug 'lervag/vimtex'
    Plug 'vim-python/python-syntax'
    Plug 'zchee/deoplete-jedi'

    " other nice little things
    Plug 'ryanoasis/vim-devicons'

call plug#end()

" ### appearance ###
set termguicolors
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_invert_tabline = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 1
colo gruvbox

" ### misc ###
set number relativenumber
set signcolumn=yes
syntax enable
filetype plugin indent on
set cursorline
set shortmess=IatO

" ### behaviour ###
set magic
set mouse=nicr " mouse with visual is messy
set clipboard=unnamed
set scrolloff=10
set history=1000
set undofile
set ignorecase smartcase
" tabs
set expandtab
set autoindent smartindent cindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

" ### airline ####
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1

" ### markdown ###
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1

" ### coc ###
set hidden
set cmdheight=2 " space for displaying messages
set updatetime=300

call coc#add_extension(
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-python',
    \ 'coc-texlab'
    \ )

call plug#begin('~/.config/nvim/plugged')

    " For appearance
    Plug 'morhetz/gruvbox'    
    Plug 'vim-airline/vim-airline'

    " git integration
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " finding files
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'junegunn/fzf', {'do': { -> fzf#install() }}

    " colours
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'ap/vim-css-color'
    Plug 'luochen1990/rainbow'

    " quality of textediting
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/vim-easy-align'
    Plug 'unblevable/quick-scope'
    Plug 'chaoren/vim-wordmotion'
    Plug 'jiangmiao/auto-pairs'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " languages + formats (most are in coc.nvim)
    Plug 'plasticboy/vim-markdown'
    Plug 'lervag/vimtex'
    Plug 'vim-python/python-syntax'
    Plug 'zchee/deoplete-jedi'
    Plug 'neovimhaskell/haskell-vim'
    Plug 'alx741/vim-stylishask'

    " other nice little things that aren't important
    Plug 'ryanoasis/vim-devicons'

call plug#end()

" ### misc ###
set number relativenumber
set signcolumn=yes
syntax enable
filetype plugin indent on
set cursorline
set shortmess=IatO

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

" ### behaviour ###
set magic
set mouse=nicr " mouse with visual is messy
set clipboard=unnamed
set scrolloff=13 " unlucky. Oooh. Spooky.
set history=1000
set undofile
set ignorecase smartcase
" tabs
set expandtab
set autoindent smartindent cindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
" splits
set splitright " top and right feels better... no politics involved please

" ### airline ####
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1

" ### wordmotion ###
" because this plugin is a little bit dodgy around these - but this solution
" is in the README so ok
nmap dw de
nmap cw ce
nmap dW dE
nmap cW cE

" ### spellchecking ###
set spelllang=en_gb
autocmd FileType text,markdown,tex setlocal spell

" ### markdown ###
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1

" ### latex ###
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'

" ### coc ###
set hidden
set cmdheight=2 " space for displaying messages
set updatetime=300

call coc#add_extension(
    \ 'coc-marketplace',
    \ 'coc-yank',
    \ 'coc-snippets',
    \ 'coc-ultisnips',
    \ 'coc-json',
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-python',
    \ 'coc-sh',
    \ 'coc-markdownlint',
    \ 'coc-vimtex',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-xml',
    \ 'coc-prettier',
    \ 'coc-vimlsp',
    \ )

" ### snippets ###
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-x>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ### quick-scope ###
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" ### easy-align ###
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ### haskell ###
let g:stylishask_on_save = 1

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1    " more traditional highlighting
" using default indent sizes

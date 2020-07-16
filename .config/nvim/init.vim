call plug#begin('~/.config/nvim/plugged')

    " For appearance
    Plug 'morhetz/gruvbox'    
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " git integration
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'rbong/vim-flog'

    " finding files
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
    Plug 'ctrlpvim/ctrlp.vim'

    " colours/highlighting
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'luochen1990/rainbow'

    " quality of textediting
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-eunuch'
    Plug 'junegunn/vim-easy-align'
    Plug 'christoomey/vim-sort-motion'
    Plug 'unblevable/quick-scope'
    Plug 'chaoren/vim-wordmotion'
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag', { 'for': ['html', 'xml'] }
    " Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'michaeljsmith/vim-indent-object'

    " the BIG things
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'

    " programming + writing (most are in coc.nvim)
    Plug 'plasticboy/vim-markdown'
    Plug 'lervag/vimtex'
    Plug 'vim-python/python-syntax'
    Plug 'zchee/deoplete-jedi'
    Plug 'neovimhaskell/haskell-vim'
    Plug 'alx741/vim-stylishask'
    " Plug 'fatih/vim-go'
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'sbdchd/neoformat'
    Plug 'vimlab/split-term.vim'

    " other nice little things that aren't important
    Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'
    Plug 'djoshea/vim-autoread'

call plug#end()

" ### shortcuts ###
let mapleader = " "

" nerdtree
nmap <leader>t :Term<CR>
nmap <leader>v :VTerm<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>s  :noh<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ### running programs ###
function RunWith(command)
    execute "w"
    execute "split | term " . a:command . " " . expand("%")
endfunction
function VRunWith(command)
    execute "w"
    execute "vsplit | term " . a:command . " " . expand("%")
endfunction

autocmd FileType python nmap <F5> :call RunWith("python")<cr>
autocmd FileType python nmap v<F5> :call VRunWith("python")<cr>

function MakeInTerm()
    execute "w"
    execute "split | term ! make"
endfunction
function VMakeInTerm()
    execute "w"
    execute "vsplit | term ! make"
endfunction

if ! file_readable("Makefile") && ! file_readable("MakeFile")
    autocmd FileType cpp nmap <F5> :call RunWith("clang++ -Wall -Wextra -pedantic -g -std=c++17 -c")<cr>
    autocmd FileType c nmap <F5> :call RunWith("clang -Wall -Wextra -pedantic -g -std=c17-c")<cr>
    autocmd FileType go nmap <F5> :call RunWith("go build")<cr>
    autocmd FileType cpp nmap v<F5> :call VRunWith("clang++ -Wall -Wextra -pedantic -g -std=c++17 -c")<cr>
    autocmd FileType c nmap v<F5> :call VRunWith("clang -Wall -Wextra -pedantic -g -std=c17-c")<cr>
    autocmd FileType go nmap v<F5> :call VRunWith("go build")<cr>
else
    autocmd FileType cpp nmap <F5> :call MakeInTerm()<cr>
    autocmd FileType c nmap <F5> :call MakeInTerm()<cr>
    autocmd FileType go nmap <F5> :call MakeInTerm()<cr>
    autocmd FileType cpp nmap v<F5> :call VMakeInTerm()<cr>
    autocmd FileType c nmap v<F5> :call VMakeInTerm()<cr>
    autocmd FileType go nmap v<F5> :call VMakeInTerm()<cr>
endif

" ### misc ###
set number relativenumber
set signcolumn=yes
syntax enable
filetype plugin indent on
syntax on
set cursorline
set shortmess=IatO
set textwidth=80
set updatetime=100
autocmd TermOpen * startinsert

" ### appearance ###
set termguicolors
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_invert_tabline = 1
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 1
let g:gruvbox_invert_selection = 0
let g:gruvbox_sign_column = 'bg0'
colo gruvbox

" ### indentation lines plugin ###
let g:indentLine_setColors = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_conceallevel = 2

lua require'colorizer'.setup()

" ### behaviour ###
set magic
set mouse=a " mouse with visual is messy
set clipboard+=unnamedplus
set scrolloff=15
set history=1000
set undofile
set ignorecase smartcase
set wildignore+=*/tmp*,*.so,*.swp,*.zip
set matchpairs+=<:>
" tabs
set expandtab
set autoindent smartindent cindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
" splits
set splitright splitbelow 

" ### airline ####
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_theme='base16_vim'

" ### wordmotion ###
let g:wordmotion_spaces = '_-./\#'
nmap dw de
nmap cw ce
nmap dW dE
nmap cW cE

" ### ctrlp ###
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" " ### spellchecking ###
set spelllang=en_gb
autocmd FileType text,markdown,tex setlocal spell

" ### markdown ###
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_toml_frontmatter = 1

" ### latex ###
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'

" ### coc ###
set hidden
set cmdheight=2 " space for displaying messages
set updatetime=300

call coc#add_extension(
    \ 'coc-marketplace',
    \ 'coc-snippets',
    \ 'coc-json',
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-python',
    \ 'coc-sh',
    \ 'coc-vimtex', 'coc-markdownlint',
    \ 'coc-html', 'coc-css', 'coc-xml',
    \ 'coc-vimlsp',
    \ 'coc-word',
    \ )

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ### snippets ###
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-x>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

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

" ### neoformat ###
autocmd BufWritePre * Neoformat

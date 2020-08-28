call plug#begin('~/.config/nvim/plugged')

    " For appearance
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'luochen1990/rainbow'

    " git integration
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'rbong/vim-flog'

    " navigation
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'vifm/vifm.vim'
    " Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mhinz/vim-grepper'
    Plug 'majutsushi/tagbar'
    Plug 'liuchengxu/vista.vim'

    " colours/highlighting
    Plug 'norcalli/nvim-colorizer.lua'

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
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'dkarter/bullets.vim'
    Plug 'metakirby5/codi.vim'

    Plug 'sbdchd/neoformat'
    Plug 'sheerun/vim-polyglot'

    " Golang
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
    "C++
    " Plug 'octol/vim-cpp-enhanced-highlight'
    " Haskell
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
    " LaTeX
    Plug 'lervag/vimtex'
    Plug 'matze/vim-tex-fold'
    " Markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    " ALE
    Plug 'dense-analysis/ale'

    " deoplete
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    " Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
    Plug 'deoplete-plugins/deoplete-jedi' " Python
    Plug 'Shougo/deoplete-clangx'
    Plug 'deoplete-plugins/deoplete-clang' " C/C++
    " Plug 'deoplete-plugins/deoplete-go', {'do': 'make'} " Go
    Plug 'Shougo/neco-vim'

call plug#end()

" ### shortcuts ###
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :Neoformat<CR>
nmap <F8> :TagbarToggle<CR>

let mapleader=" "

nnoremap <leader>s :noh<CR>
nnoremap <leader>rt :RainbowToggle<CR>
nnoremap <leader>vf :Vifm<CR>
nnoremap <leader>ad :ALEDetail<CR>

nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>a :cclose<CR>
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
"
" More natural movement when lines wrap
noremap j gj
noremap k gk
nnoremap gj 5j
nnoremap gk 5k
" Because of vim-wordmotion
nmap dw de
nmap cw ce
nmap dW dE
nmap cW cE

" ### behaviour ###
set autowrite
set magic
set mouse=a " mouse with visual is messy
set clipboard+=unnamedplus
set scrolloff=10
set history=1000
set undofile
set ignorecase smartcase
set wildignore+=*/tmp*,*.so,*.swp,*.zip
set matchpairs+=<:>
let g:AutoPairsFlyMode = 0
" tabs
set expandtab
set cindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
" splits
set splitright splitbelow 

" ### misc ###
set number relativenumber
set signcolumn=yes
syntax enable
filetype plugin indent on
syntax on
set cursorline
set shortmess=IatOc
set spelllang=en_gb
set updatetime=50
autocmd TermOpen * startinsert

" ### spellcheck ###

" " ### spellchecking ###
autocmd FileType text,markdown,tex setlocal spell
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction
nnoremap z= :call FzfSpell()<CR>

" ### quick-scope colours ###
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

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
let g:rainbow_active = 1

let g:airline_theme = "base16_vim"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" ### deoplete ###
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ### ultisnips ### 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsEditSplit="vertical"

" ### LaTeX ###
let g:tex_flavor = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_compiler_progname = 'pdflatex'

" ### markdown ###
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:pandoc#folding#fdc = 0
let g:pandoc#formatting#textwidth = 70
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
autocmd Filetype markdown set textwidth=70

" ### Bullets.vim ###
" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]

" ### Golang ####
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_completion_enabled = 1
let g:go_test_show_name = 1
let g:go_info_mode = "guru"
let g:go_list_height = 10
let g:go_diagnostics_enabled = 1
let g:go_template_autocreate = 0
let g:go_auto_type_info = 1
let g:go_auto_sameids = 0


" ### C++ highlighting ###
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1
let c_no_curly_error=1

" ### ALE ###
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 0
let g:ale_set_balloons = 1
let g:ale_set_preview= 1
let g:ale_hover_to_preview=1
let g:ale_linters = {}
let g:ale_linters.bash = ['shellcheck']
let g:ale_linters.c = ['clang']
let g:ale_linters.cpp = ['clang']
let g:ale_linters.haskell = ['hslint']
let g:ale_linters.latex = ['texlab']
let g:ale_linters.markdown = ['prettier']
let g:ale_linters.python = ['black', 'flake8']
" no go linters, instead just vim-go
let g:ale_fixers = {}
let g:ale_fixers.bash = ['shfmt']
let g:ale_fixers.haskell = ['stylish-haskell']
let g:ale_fixers.python = ['black']
let g:ale_fixers.cpp = ['clang-format']
let g:ale_fixers.c = ['clang-format']
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

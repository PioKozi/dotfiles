call plug#begin('~/.config/nvim/plugged')

    " For appearance
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'luochen1990/rainbow'
    Plug 'Yggdroot/indentLine'

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

    " colours/highlighting
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'octol/vim-cpp-enhanced-highlight'

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
    Plug 'metakirby5/codi.vim'
    Plug 'sbdchd/neoformat'

    " LaTeX
    Plug 'lervag/vimtex'
    " Markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    Plug 'sbdchd/vim-run'

    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }

call plug#end()

" define makeprg if Makefile is not present
if !file_readable('Makefile') && !file_readable('makefile')
    autocmd Filetype cpp setlocal makeprg=clang++\ -Wall\ -Werror\ -Wpedantic\ %
    autocmd Filetype c setlocal makeprg=clang\ -Wall\ -Werror\ -Wpedantic\ %
    autocmd Filetype go setlocal makeprg=go\ build\ %
    autocmd Filetype haskell setlocal makeprg=ghc\ %
endif

" ### shortcuts ###
map <F1> :NERDTreeToggle<CR>
map <F2> :Neoformat<CR>
map <F3> :Vifm<CR>
map <F4> :copen<CR>
autocmd Filetype python,sh,go map <F5> :Run<CR>
autocmd Filetype cpp,c,haskell map <F5> :make<CR>
map <F6> :FZF<CR>
map <F7> :call TermToggle(12)<CR>
map <F8> :TagbarToggle<CR>

" make normal mode Fkey shortcuts work in insert mode
imap <F1> <C-\><C-N> :NERDTreeToggle<CR>
imap <F2> <C-\><C-N> :Neoformat<CR>
imap <F3> <C-\><C-N> :Vifm<CR>
imap <F4> <C-\><C-N> :copen<CR>
autocmd Filetype python,sh,go imap <F5> :Run<CR>
autocmd Filetype cpp,c,haskell imap <F5> :make<CR>
imap <F6> <C-\><C-N> :FZF<CR>
imap <F7> <C-\><C-N> :call TermToggle(12)<CR>
imap <F8> <C-\><C-N> :TagbarToggle<CR>

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

let mapleader=" "

nnoremap <leader>s :noh<CR>
nnoremap <leader>rt :RainbowToggle<CR>
nnoremap <leader>vf :Vifm<CR>

nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>a :cclose<CR>
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
let g:rainbow_active = 0

let g:airline_theme = "base16_vim"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" ### IndentLine ###
let g:indentLine_char_list = ['┊', '┆', '¦', '|']
let g:indentLint_showFirstIndentLevel = 1
let g:indentLine_setColors = 1

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

" ### LSP ###
set hidden

let g:LanguageClient_serverCommands = {
    \ 'python' : ['/usr/bin/pyls'],
    \ 'go' : ['/home/piotr/go/bin/gopls'],
    \ 'cpp' : ['/usr/bin/ccls'],
    \ 'c' : ['/usr/bin/ccls'],
    \ 'sh' : ['/usr/bin/bash-language-server','start'],
    \ 'haskell': ['/usr/bin/haskell-language-server-wrapper', '--lsp'],
    \ 'vim' : ['/usr/bin/vim-language-server'],
    \ }

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()
augroup LSP
  autocmd!
  autocmd FileType python,cpp,c,go,sh,haskell,vim call SetLSPShortcuts()
augroup END

" ### Deoplete ###
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)

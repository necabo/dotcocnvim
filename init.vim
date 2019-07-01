call plug#begin('~/.cocnvim/plugged')
    Plug 'airblade/vim-rooter'                                              " change working directory to project root
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }       " fzf binary
    Plug 'junegunn/fzf.vim'                                                 " fzf vim utils

    " coc and extension plugins
    Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}                " completions, LSP, etc.
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}      " coc-json extension
    Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}       " coc-rls extension
    Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}    " coc-python extension
    Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}       " coc-git extension

    Plug 'NLKNguyen/papercolor-theme'                                       " eye-friendly colorscheme
    Plug 'itchyny/lightline.vim'                                            " status bar
    Plug 'tpope/vim-fugitive'                                               " git integration
    Plug 'scrooloose/nerdtree'                                              " file browsing
    Plug 'tpope/vim-commentary'                                             " commenting
    Plug 'ludovicchabant/vim-gutentags'                                     " tag file management
    Plug 'jiangmiao/auto-pairs'                                             " brackets auto-closing
call plug#end()

let mapleader = "\<Space>"

set hidden
set title
set modeline
set modelines=5
set cursorline
set encoding=utf-8
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set inccommand=nosplit

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
" remove highlighting of previous search results
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

:highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:match ExtraWhitespace /\s\+$/

nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
" remove highlighting of previous search results
nnoremap <silent> <Leader>/ :nohlsearch<CR>

set background=dark
silent! colorscheme PaperColor

set pastetoggle=<F3>
set guicursor=

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c


" --------------------------------------------------------------------------------
" fzf                                                                            |
" --------------------------------------------------------------------------------
let $FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!*/.git/*'"
noremap <F4> :FZF<CR>
inoremap <F4> <esc>:w<CR>:FZF<CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!*/.git/*" --glob "!tags" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" --------------------------------------------------------------------------------
" coc.nvim                                                                       |
" --------------------------------------------------------------------------------
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" always show signcolumns
set signcolumn=yes
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentationin preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
highlight CocHighlightText cterm=bold gui=bold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" --------------------------------------------------------------------------------
" coc.nvim                                                                       |
" --------------------------------------------------------------------------------
augroup python_isort
  autocmd!
  autocmd FileType python autocmd BufWritePre <buffer> :CocCommand python.sortImports
augroup end

" --------------------------------------------------------------------------------
" lightline.vim
" --------------------------------------------------------------------------------
" Don't show modes as lightline also does so
set noshowmode

let g:lightline = {
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               ['cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'percent' ],
  \                [ 'fileformat', 'fileencoding', 'filetype' ] ],
  \   },
  \   'component_function': {
  \     'gitbranch': 'LightLineFugitive',
  \     'fileformat': 'LightLineFileformat',
  \     'filetype': 'LightLineFiletype',
  \     'cocstatus': 'coc#status',
  \   },
  \ }

function! LightLineFugitive()
  let _ = fugitive#head()
  return strlen(_) ? "\uf126 "._ : ""
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" --------------------------------------------------------------------------------
" nerdtree
" --------------------------------------------------------------------------------
noremap <F2> :NERDTreeToggle<CR>

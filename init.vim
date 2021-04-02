call plug#begin('~/.cocnvim/plugged')

    " coc and extension plugins
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}              " completions, LSP, etc.
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}              " coc-json extension

    Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}  " coc-rust-analyzer extension

    Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}            " coc-python extension
    Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}               " coc-git extension
    Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}          " coc-snippets extension
    Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}              " coc-java extension

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }               " fzf binary
    Plug 'junegunn/fzf.vim'                                                         " fzf vim utils
    Plug 'NLKNguyen/papercolor-theme'                                               " eye-friendly colorscheme
    Plug 'itchyny/lightline.vim'                                                    " status bar
    Plug 'scrooloose/nerdtree'                                                      " file browsing
    Plug 'jiangmiao/auto-pairs'                                                     " brackets auto-closing
    Plug 'honza/vim-snippets'                                                       " snippets for various languages
    Plug 'editorconfig/editorconfig-vim'                                            " https://editorconfig.org/

    " tpope is awesome!
    Plug 'tpope/vim-fugitive'                                                       " git integration
    Plug 'tpope/vim-commentary'                                                     " commenting
    Plug 'tpope/vim-surround'                                                       " change surroundings in place
    Plug 'tpope/vim-repeat'                                                         " allow repeating plugin mappings
    Plug 'tpope/vim-unimpaired'                                                     " handy bracket mappings
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

nnoremap Y y$
" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

:highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:match ExtraWhitespace /\s\+$/

nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

set pastetoggle=<F3>
set guicursor=

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" set colorscheme
set background=dark
silent! colorscheme PaperColor

" --------------------------------------------------------------------------------
" fzf                                                                            |
" --------------------------------------------------------------------------------
map <silent><expr> <C-p> fugitive#head() != '' ? ':GFiles --cached --others --exclude-standard<CR>' : ':Files<CR>'

let g:fzf_layout = {'window': {'width': 0.90, 'height': 0.90}}
let g:fzf_preview_window = 'right:70%'

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
command! -bang -nargs=* RgAll call fzf#vim#grep('rg --column --line-number --no-heading --ignore-case --no-ignore --hidden --follow --glob "!*/.git/*" --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

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
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <silent><leader>a  <Plug>(coc-codeaction-selected)
nmap <silent><leader>a  <Plug>(coc-codeaction-selected)w

" Remap keys for applying codeAction to the current buffer.
nmap <silent><leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <silent><leader>qf  <Plug>(coc-fix-current)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use gh to show documentation in preview window
nmap <silent> gh :call CocAction('doHover')<CR>

" Allow scrolling in preview window
nnoremap <expr><C-d> coc#float#has_float() ? coc#float#scroll(1) : "<C-d>"
nnoremap <expr><C-u> coc#float#has_float() ? coc#float#scroll(0) : "<C-u>"
nnoremap <silent><expr><Esc> coc#float#has_float() ? ":call coc#float#close_all()<CR>" : "<Esc>"

" Highlight symbol under cursor on CursorHold
highlight CocHighlightText cterm=bold gui=bold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

let g:python3_host_prog='/usr/bin/python3'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

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

" --------------------------------------------------------------------------------
" editorconfig-vim
" --------------------------------------------------------------------------------
let g:EditorConfig_max_line_indicator = "none"

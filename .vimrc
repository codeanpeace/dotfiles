" On-demand loading
call plug#begin('~/.vim/plugged')

" UI Enhancements
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'

" search enhancements
Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'liuchengxu/vim-which-key'

" manipulation enhancements
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'preservim/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'

" navigation enhancements
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-easyoperator-line'
Plug 't9md/vim-choosewin'
Plug 'sjl/gundo.vim'

" terminal & tmux interop enhancements
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-obsession'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'

" language enhancements
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'

" writing enhancements
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Add plugins to &runtimepath
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" General mappings

" Remap leader key to space
nmap <SPACE> <Nop>
let g:mapleader="\<Space>"

" Swap ; and : in normal mode for easier command mode access
" nmap ; :
" nmap : ;

" edit dotfiles eg .vimrc, .zshrc, .tmux.conf
nmap <leader>dv :vsp $MYVIMRC<CR>
nmap <leader>dz :vsp ~/.zshrc<CR>
nmap <leader>dt :vsp ~/.tmux.conf<CR>
nmap <leader>ds :source $MYVIMRC<CR>

" switch to next/previous buffer with tab/shift+tab
nmap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nmap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nmap <silent> <leader>a :b#<cr>

" close buffer without changing window layout
nmap <C-x> :bp\|bd #<CR>

" shortcut to save
" map <Esc><Esc> :w<CR>

" move vertically by visual line
nmap j gj
nmap k gk

" move lines up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" highlight last inserted text
nmap gV `[v`]

""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme mirodark     " set colorscheme
colorscheme nord         " set colorscheme

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration

" vim airline for status and tab line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = "unique_tail"

" tmux status line config generator
"let g:tmuxline_status_justify = 'centre'
"let g:tmuxline_separators = {
      "\ 'left' : '',
      "\ 'left_alt': '>',
      "\ 'right' : '',
      "\ 'right_alt' : '<',
      "\ 'space' : ' '}
"let g:tmuxline_preset = {
      "\'a'    : '#(whoami)',
      "\'b'    : '#S',
      "\'win'  : '#I #W',
      "\'cwin' : '#I #W',
      "\'y'    : '%R',
      "\'z'    : '#h'}

" File tree via nerdtree
nmap <leader>tr :NERDTree<CR>
nmap <leader>tf :NERDTreeFind<CR>
nmap <leader>tx :NERDTreeFocus<CR>
nmap <leader>tt :NERDTreeToggle<CR>

" Window pane hints, invoke with '-'
nmap  -  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" Faster grep with ripgrep
if executable('rg')
  " Use rg over grep
  set grepprg=ag\ --nogroup\ --nocolor
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  nmap <silent> <space>/ :Rg<CR>
  " search only file contents, ignore file name
  " https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
  command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf fuzzy finder configuration

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Border style (rounded / sharp / horizontal)
let g:fzf_layout = { 'window': {
  \ 'width': 0.9,
  \ 'height': 0.6,
  \ 'highlight': 'Todo',
  \ 'border': 'sharp' } }

" Mapping selecting mappings
nmap <leader><tab> <Plug>(fzf-maps-n)
xmap <leader><tab> <Plug>(fzf-maps-x)
omap <leader><tab> <Plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <Plug>(fzf-complete-word)
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-j> <Plug>(fzf-complete-file-ag)
imap <c-x><c-l> <Plug>(fzf-complete-line)

" Shortcuts
nmap <silent> <C-p> :Files<CR>
nmap <silent> <C-g> :GitFiles<CR>
nmap <silent> <C-t> :Buffers<CR>
nmap <silent> <leader>ff :Files<CR>
nmap <silent> <leader>fg :GitFiles<CR>
nmap <silent> <leader>fb :Buffers<CR>
nmap <silent> <leader>fl :Lines<CR>
nmap <silent> <leader>fm <Plug>(fzf-maps-n)

""""""""""""""""""""""""""""""""""""""""""""""""""
" WhichKey configuration

nmap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
"map <Leader>m <Plug>(easymotion-prefix)
" hack to support whichkey
map <Leader>m :WhichKey! easymotion_which_key_map<CR>
let g:easymotion_which_key_map = {
  \ 'name' : '+Easymotion ' ,
  \ 'f' : ['<plug>(easymotion-prefix)f' , 'find {char} to the right'],
  \ 'F' : ['<plug>(easymotion-prefix)F' , 'find {char} to the left'],
  \ 't' : ['<plug>(easymotion-prefix)t' , 'till before the {char} to the right'],
  \ 'T' : ['<plug>(easymotion-prefix)T' , 'till after the {char} to the left'],
  \ 'w' : ['<plug>(easymotion-prefix)w' , 'beginning of word forward'],
  \ 'W' : ['<plug>(easymotion-prefix)W' , 'beginning of WORD forward'],
  \ 'b' : ['<plug>(easymotion-prefix)b' , 'beginning of word backward'],
  \ 'B' : ['<plug>(easymotion-prefix)B' , 'beginning of WORD backward'],
  \ 'e' : ['<plug>(easymotion-prefix)e' , 'end of word forward'],
  \ 'E' : ['<plug>(easymotion-prefix)E' , 'end of WORD forward'],
  \ 'g' : {
    \ 'name' : '+Backwards ' ,
    \ 'e' : ['<plug>(easymotion-prefix)ge' , 'end of word backward'],
    \ 'E' : ['<plug>(easymotion-prefix)gE' , 'end of WOR<F25>D backward'],
    \ },
  \ 'j' : ['<plug>(easymotion-prefix)j' , 'line downward'],
  \ 'k' : ['<plug>(easymotion-prefix)k' , 'line upward'],
  \ 'n' : ['<plug>(easymotion-prefix)n' , 'jump to latest "/" or "?" forward'],
  \ 'N' : ['<plug>(easymotion-prefix)N' , 'jump to latest "/" or "?" backward.'],
  \ 's' : ['<plug>(easymotion-prefix)s' , 'find(search) {char} forward and backward.'],
\ }
autocmd! User vim-which-key call which_key#register('<Space>', "g:which_key_map")

""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration

set nocompatible             " choose no compatibility with legacy vi
set encoding=utf-8           " standard utf-8 encoding
set modelines=0              " close security hole
set showcmd                  " display incomplete commands
set showmode                 " show the current mode
set ruler                    " show ruler
set autoindent               " enable autoindent
set hidden                   " hides buffers instead of closing them
set ttyfast                  " better scrolling
set undofile                 " creates undo files
set history=100              " history
set undolevels=100           " undo levels
set autowrite                " automatically :write before running commands
set mouse=a                  " enable mouse for scrolling

filetype plugin indent on    " load file type plugins + indentation
syntax enable                " enable syntax processing

" Tab
set tabstop=2	                  " number of visual spaces per TAB
set shiftwidth=2                " number of visual spaces per TAB
set softtabstop=2               " number of spaces in tab when editing
set expandtab                   " tabs are spaces set backspace=indent,eol,start  " sensible backspace in insert mode
set smarttab                    " insert “tabstop” number of spaces when the “tab” key is pressed
set shiftround                  " use multiple of shiftwidth with '<' & '>'
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Appearance
set number                   " show line numbers
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set lazyredraw	             " redraw only when we need to
set showmatch                " highlight matching [{()}]
set scrolloff=10             " scroll offset, 10 lines above & below cursor
set wrap                     " word wrap
set textwidth=80             " text width
set colorcolumn=+1           " color column
set laststatus=2             " always display the status line
set title                    " change the terminal's title
set visualbell               " don't beep
set noerrorbells             " don't beep
set showbreak=↪              " show line breaks
set guicursor+=n:hor20-Cursor/lCursor
set wildignore=*.swp,*.bak,*.pyc,*.class
" set ts=2 sw=2 et
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
" set background=dark

" Search
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set gdefault " global subsitution by default

" Fold
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" Splits
" more natural default opening
set splitbelow
set splitright

au FocusLost * :wa " save on focus lost
autocmd BufWritePre * StripWhitespace " strip whitespace on save

" Enable copying to clipboard using `CTRL + c`
map <C-c> y:e ~/clipsongzboard<CR>P:w !pbcopy<CR><CR>:bdelete!<CR>
if $TMUX == ''
  if has("clipboard")
    set clipboard+=unnamed " copy to the system clipboard
    if has("unnamedplus") " X11 support
      set clipboard+=unnamedplus
    endif
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" Configure language specific settings

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""
" Consolidate swap, backup, and undo files

" swap files (.swp) in a common location
" // means use the file's full path
set dir=~/.vim/_swap//

" backup files (~) in a common location if possible
set backup
set backupdir=~/.vim/_backup/,~/tmp,.

" turn on undo files, put them in a common location
set undofile
set undodir=~/.vim/_undo/

""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Functions

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""
" Writing Mode

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set breakindent
  set linebreak
  set linespace=7
  set scrolloff=999
  Limelight
  Pencil
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set nobreakindent
  set nolinebreak
  set linespace=0
  set scrolloff=5
  Limelight!
  PencilOff
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"        Michael Ratliff (iammer)'s .vimrc          "
"                                                   "
"   If you know what this is, then you know what    "
"   this is.  If you don't know what this is, why   "
"   are you looking at it?                          "
"                                                   "
"   Almost all of this was shamelessly stolen       "
"   from somewhere else.                            "
"                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"I don't like polyglots js indentation
"let g:polyglot_disabled = ['indent']

let g:copilot_node_command = "/opt/node20/bin/node"
let g:coc_node_path = "/opt/node20/bin/node"

"----------Plugins-------------
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'tpope/vim-vividchalk'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dotenv'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/camelcasemotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'

Plug 'https://github.com/github/copilot.vim.git'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

Plug 'iammer/spin.vim'
Plug 'iammer/ReplaceWithRegister'

call plug#end()

lua << EOF
if vim.fn.has('nvim-0.9.5') == 1 then
  require("CopilotChat").setup {
  }
end
EOF

""for airline
"set laststatus=2
"set encoding=utf-8
"
"" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set backupskip=/tmp/*,/private/tmp/* " fix issue with crontab (See :h crontab)
set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

"use undofiles to persist undo
set undofile
set undodir=~/.local/share/nvim/undo,/tmp,.

set number
set hidden
set autoindent		" always set autoindenting on

set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab shiftround
set noequalalways
set splitright

set cursorline
set lazyredraw

set autoread "automatically reload externally modified files if they have not been modified locally

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set display+=lastline " Display as much of a line as possible even if the whole line won't fit on the screen

set mouse= "Disable mouse (Neovim enables by default)

"Use blowfish encryption if available
if v:version > 702 && !has("nvim")
	set cryptmethod=blowfish
endif

""---------Plugin Config----------
"for easymotions
let g:EasyMotion_mapping_f = '<leader>f'
let g:EasyMotion_mapping_F = '<leader>F'
let g:EasyMotion_mapping_w = '<leader>]'
let g:EasyMotion_mapping_b = '<leader>['

"
"Replace with register config
nmap S <Plug>ReplaceWithRegisterOperator

"CtrlP Config
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_use_caching = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = {
 \ 'file': '\v\.(class|jar)$',
 \ 'dir': '\v[\/](target|build|.git|node_modules|tmp|bower_components|dist|target-eclipse|qa)'
 \ }
let g:ctrlp_prompt_mappings = { 'PrtClearCache()': ['<F5>','<c-i>'] }
let g:ctrlp_open_multiple_files = '1hjr'

"Make ^Wf use CtrlP
nmap <C-W>f <C-P><C-\>w

set bg=dark
"Colorschemes are in a plugin so must be loaded late
colorscheme iammer
"
""Airline config
if !exists ("g:airline_symbols")
	let g:airline_symbols={}
endif
let g:airline_symbols.linenr='L'
"let g:airline_left_sep="▶"
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_mode_map = {
	\ '__'     : '-',
	\ 'c'      : 'C',
	\ 'i'      : 'I',
	\ 'ic'     : 'I',
	\ 'ix'     : 'I',
	\ 'n'      : 'N',
	\ 'multi'  : 'M',
	\ 'ni'     : 'N',
	\ 'no'     : 'N',
	\ 'R'      : 'R',
	\ 'Rv'     : 'R',
	\ 's'      : 'S',
	\ 'S'      : 'S',
	\ ''     : 'S',
	\ 't'      : 'T',
	\ 'v'      : 'V',
	\ 'V'      : 'V',
	\ ''     : 'V',
	\ }
"let g:airline_right_sep="◀"
"let g:airline_inactive_collapse = 0
"
"let g:airline_section_b="%<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"
"let g:airline_section_b="%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}%{airline#util#wrap(airline#extensions#branch#get_head(),0)}"
let g:airline_section_b=""
let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#tagbar#enabled = 0
""
"signify config
let g:signify_vcs_list=['git','svn']
let g:signify_disable_by_default=1
let g:signify_sign_change='~'
"
"Use ag if available
if executable('ag')
	let g:ackprg = 'ag --vimgrep --smart-case --ignore=*.log'
endif
""let g:ack_use_dispatch = 1
"

"Fix html indentation
let g:html_indent_inctags = "html,body,head,tbody"

"--------Remaps--------
"Make jk work like escape
inoremap jk <esc>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"default to very magic
nnoremap / /\v

"This makes more sense
nnoremap Y y$

"Make enter and space in normal mode work like they do in insert mode
nnoremap <CR> i<CR><ESC>
nnoremap <SPACE> i<SPACE><ESC>

" Don't use Ex mode, use Q for formatting
map Q gq

"easier visual mode indent
vnoremap , <gv
vnoremap . >gv

""-----Leader Remaps-----
"nnoremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
"nnoremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
"nnoremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
"nnoremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <leader>em :vsp $MYVIMRC<CR>
nnoremap <leader>sm :so $MYVIMRC<CR>

nnoremap <leader>h :noh<CR>
"
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
"
"Leader toggles
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>p :set paste!<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>m :call g:ToggleNumberMode()<CR>
"
"create lines above and below without insert mode
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j
"
"nnoremap <leader>. :CtrlPTag<CR>
"nnoremap <leader>it :Start! ctags -R<CR>
"
nnoremap <leader>c :call g:ToggleConceal()<CR>
"
"sort block with gs
nnoremap gS gs
nnoremap gs Vip:sort u<CR>

nnoremap <leader>s :SignifyToggle<CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

"Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
	autocmd!

	autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

	" Filetype aliases
	autocmd BufNewFile,BufRead *.schema set filetype=javascript
	autocmd BufNewFile,BufRead *.less set filetype=css
	autocmd BufNewFile,BufRead *.md set filetype=markdown
	autocmd BufNewFile,BufRead *.rs set filetype=rust
	autocmd BufNewFile,BufRead *.fxml set filetype=xml

	" Don't use a swap file when editing a file in dropbox
	autocmd BufNewFile,BufRead */Dropbox/* setlocal noswf

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType scss setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType eruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType haskell setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround
	autocmd FileType typescript setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround
	autocmd FileType javascript setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround
	autocmd FileType handlebars setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType handlebars.ember setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType hbs setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType spin setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
	autocmd FileType haskell setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround

	autocmd FileType nim setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround

	autocmd FileType ruby let @w = "^yiWIputs \"\": #{A}\"j^"
	autocmd FileType javascript let @w = "^y$iconsole.log(`A: ${pA}`);j^"

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default

	" position when opening a file.
	autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

augroup END

function! g:ToggleNumberMode()
	if (&rnu==1)
		set nornu
	else
		set rnu
	endif
endfunc

function! g:ToggleConceal()
	if (&conceallevel)
		setlocal conceallevel=0
	else
		setlocal conceallevel=2
	endif
endfunction

function! s:env(var) abort
  return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

"----------Commands-------------

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

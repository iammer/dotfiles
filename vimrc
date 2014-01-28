" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

:runtime bundle/vim-pathogen/autoload/pathogen.vim

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Make .schema use javascript highlighting
  autocmd BufNewFile,BufRead *.schema set filetype=javascript
  
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

nmap S <Plug>ReplaceWithRegisterOperator

call pathogen#infect()
call pathogen#helptags()

set number
set hidden
set autoindent		" always set autoindenting on

set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab shiftround
set splitright
"set splitbelow

colorscheme vividchalk

let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = {
 \ 'file': '\v\.(class|jar)$',
 \ 'dir': '\v[\/](target|build|.git)'
 \ }

let g:ctrlp_prompt_mappings = { 'PrtClearCache()': ['<F5>','<c-i>'] }

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
  
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

nnoremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <leader>em :vsp $MYVIMRC<CR>
nnoremap <leader>sm :so $MYVIMRC<CR>

nnoremap <leader>h :noh<CR>

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

nnoremap <leader>w :set wrap!<CR>

nnoremap <leader>p :set paste!<CR>

inoremap jk <esc>

"comma mappings for args
nnoremap di, f,dT,
nnoremap ci, f,cT,
nnoremap da, f,ld2F,i,<ESC>l
nnoremap ca, f,ld2F,i,<ESC>a

"default to very magic
nnoremap / /\v

"create lines above and below without insert mode
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j

"-----Functions------
function! SearchGlobalFunc(searchStr)
	enew
	setlocal nonumber
	execute "read !for f in $(find . -type f -exec grep -q -I " . a:searchStr
	\ . " \"{}\" \\; -print); do  echo \"$f :\"; grep -n -C 10 " . a:searchStr 
	\ . " \"$f\" ; printf \"\\n\\n\"; done"
	execute "normal! gg/" . a:searchStr . "\n"
	let @/ = a:searchStr
	set hlsearch
endfunction

command! -nargs=1 SearchGlobal :call SearchGlobalFunc("<args>")

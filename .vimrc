set nocompatible
if has ("autocmd")
    if !exists("autocommands_loaded")
        let autocommands_loaded = 1
        filetype on
        filetype indent on
        filetype plugin on
        autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vim
"        autocmd BufRead,BufNewFile,FileReadPost *.csv,*.csv.gz source ~/.vim/ftplugin/csv
    endif
endif

set cpoptions=BF
" When included, a ":write" command with a file name argument will set the file name for the current buffer,
" if the current buffer doesn't have a file name yet.  Also see |cpo-P|.
" 'B' is to stop cpoptions breaking vim

set encoding=utf-8
set laststatus=2
set number
set ruler
set sta sts=4 ai
set tw=78 ts=4 sw=4 sta et sts=4 ai
syntax enable
"fix backspace:
set backspace=indent,eol,start

set history=10000

set cindent
set cinkeys=0{,0},!^F,o,O,e "

" jump to the last position when reopening a file
if !&diff
    if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    endif
endif

" Disable stupid, fucking annoying beeps
set noerrorbells visualbell t_vb=


nnoremap <C-n> :call NumberToggle()<cr>
if version == 703
  set number
  function! NumberToggle()
    if(&number == 1)
      set relativenumber
    elseif(&relativenumber == 1)
      set nonumber
      set norelativenumber
    else
      set number
    endif
  endfunc
elseif version >= 704
    set number
    set relativenumber
    function! NumberToggle()
      if(&number == 1) && (&relativenumber == 1)
        set norelativenumber
        set nonumber
      elseif(&number == 1)
        set relativenumber
      else
        set number
      endif
    endfunc
else 
  function! NumberToggle()
    if(&number == 1)
      set nonumber
    else
      set number
    endif
  endfunc
endif


if has("persistent_undo")
  set undodir=/var/userspace/pauric/vim_changes
  set undofile
endif

" Some fancy features

set foldmethod=manual
set wildmenu
set showmatch
set incsearch
set ignorecase
set smartcase
set hls

set noswapfile " I just hate them for some reason

" Themes, I guess
colorscheme wombat256
if &diff
    colorscheme slate
endif

"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

set mouse-=a
"set list "show whitespace

"Plugin specific stuff
let g:pymode_folding = 0
let g:pymode_lint = 0

let g:fortune_vimtips_auto_display = 0

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"nice scrolling by line
nmap <C-DOWN> <C-e>
nmap <C-UP> <C-y>
nmap <C-j> <C-e>
nmap <C-k> <C-y>

nnoremap <C-W>O :call MaximizeToggle ()<CR>
nnoremap <C-W>o :call MaximizeToggle ()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle ()<CR>

" Insert a newline without entering insert mode
nnoremap <Leader>O O<Esc>
nnoremap <Leader>o o<Esc>

" Use \d (or \dd or \dj or 20\dd) to delete a line without adding it to the
" yanked stack
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" These are kind of nice to use, but ';' defaults to finding next instance of
" character found with f/F
"nnoremap ; :
"vnoremap ; :

" Make up or jk keys also scroll up on current line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" Page up / page down to move through tabs
nnoremap <leader><PageUp> :tabprevious<Cr>
nnoremap <leader><PageDown> :tabnext<Cr>

" Leave insert mode by hitting jj
inoremap jj <Esc>

" Replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
"
" Remove search highlighting after search
nnoremap <space> :nohls<CR>

" Move back to previous editing spot after using . to repeat command
nmap . .`[

set pastetoggle=<F2>
map <F3> :set wrap!<cr>

" Folding
" let g:xml_syntax_folding=1
" au FileType xml setlocal foldmethod=syntax
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
nnoremap <F10> zR

" List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F5> :GundoToggle<CR>

let g:jedi#popup_on_dot = 0

" Use pathogen, and associated plugins
call pathogen#infect()

let g:syntastic_python_checker = 'pyflakes'
nnoremap <leader>z :SyntasticCheck<CR>

map <F4> :NERDTreeToggle<CR>


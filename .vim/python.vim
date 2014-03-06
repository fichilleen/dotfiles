" The magical turn-Vim-into-a-Python-IDE vim resource file!
"
" Mostly taken from http://www.sontek.net/category/Vim.aspx
" Other bits culled from various sources, Canonical guys, or made up by me.
"
" Julian Edwards 2008-05-30
"
" Modified after by fich - 2011-2014

" Wrapping and tabs.
set tw=78 ts=4 sw=4 sta et sts=4 ai

" More syntax highlighting.
let python_highlight_all = 1
setlocal foldmethod=indent
setlocal foldlevel=99
normal zR

set completeopt-=preview
set completeopt+=longest

" Smart indenting
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>

" Get this plugin from http://www.vim.org/scripts/script.php?script_id=1112
" Pressing "K" takes you to the documentation for the word under the cursor.
"autocmd filetype python source ~/.vim/pydoc.vim

" Wrap at 72 chars for comments.
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

if has("python")
    source ~/.vim/with_py.vim 
endif

" The next two highlight matches break the previous one, I don't know why.
" Show long lines.
"highlight LongLine guibg=red ctermbg=red
"match LongLine /\%>79v.\+/
" Highlight bzr merge markers.
"highlight MergeMarker guibg=red ctermbg=red
"match MergeMarker /^[<=>\|]\{7\}\( [A-Z]\+\)?$/


" Generate tags with: ctags -R -f ~/.vim/tags/python24.ctags /usr/lib/python2.4/
" ctrl-[ to go to the tag under the cursor, ctrl-T to go back.
set tags+=$HOME/.vim/tags/python.ctags

" Use :make to see syntax errors. (:cn and :cp to move around, :dist to see
" all errors)
set makeprg=python2.7\ -B\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

if version >= 703
  set relativenumber
endif

"vim:syntax=vim

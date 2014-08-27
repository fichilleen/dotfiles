#!/bin/zsh

# This is really just for licensing reasons, and stuff like that.
# When hosting dotfiles on github, I don't want to include other peoples'
# code, even if it is under a free license. Might as well get the newest
# version on a new install anyway.

mkdir -p ~/.vim/bundle
pushd ~/.vim/bundle

# vim-snipmate
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/honza/vim-snippets.git

# gundo
git clone http://github.com/sjl/gundo.vim.git

# jedi-vim
git clone --recursive https://github.com/davidhalter/jedi-vim.git

# nerdtree
git clone https://github.com/scrooloose/nerdtree.git

# syntastic
git clone https://github.com/scrooloose/syntastic.git

# powerline
git clone https://github.com/Lokaltog/vim-powerline


# End of plugins
pushd



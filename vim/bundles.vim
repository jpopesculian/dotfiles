if &compatible
  set nocompatible
end

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle "gmarik/vundle"

" General
Bundle "editorconfig/editorconfig-vim"
Bundle "Valloric/YouCompleteMe"
Bundle "flazz/vim-colorschemes"
Bundle "jeffkreeftmeijer/vim-numbertoggle"
Bundle "rking/ag.vim"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/syntastic"
Bundle "skwp/greplace.vim"
Bundle "tomtom/tcomment_vim"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "airblade/vim-gitgutter"
Bundle "tpope/vim-unimpaired"
" Snippets
Bundle "sirver/ultisnips"

" Javascript
Bundle "marijnh/tern_for_vim"
Bundle "pangloss/vim-javascript"
Bundle "jelera/vim-javascript-syntax"
Bundle "othree/javascript-libraries-syntax.vim"
Bundle "kchmck/vim-coffee-script"
" JSON
Bundle "elzr/vim-json"

" HTML
Bundle "othree/html5.vim"
Bundle "edsono/vim-matchit"

" CSS
Bundle "hail2u/vim-css3-syntax"
" Less
Bundle "groenewege/vim-less"

" Python
" Bundle "davidhalter/jedi-vim" " trying out ycm instead
" Bundle "klen/python-mode"

" Ruby
" HAML
" (also contains sass)
Bundle "tpope/vim-haml"
" YAML
Bundle "ingydotnet/yaml-vim"
Bundle "chase/vim-ansible-yaml"

" Clojure
Bundle "guns/vim-sexp"
Bundle "tpope/vim-sexp-mappings-for-regular-people"
Bundle "guns/vim-clojure-static"
Bundle "tpope/vim-leiningen"
Bundle "tpope/vim-fireplace"
Bundle "guns/vim-clojure-highlight"
Bundle "junegunn/rainbow_parentheses.vim"

" Haskell
Bundle "haskell.vim"
Bundle "dag/vim2hs"

" Markdown / Writing
Bundle "reedes/vim-wordy"
" Bundle "vim-pandoc/vim-pandoc"
" Bundle "vim-pandoc/vim-pandoc-syntax"
" bug in ftplugin with tabstop/shiftwidth Bundle "PProvost/vim-markdown-jekyll"

" Roku Brightscript
Bundle "chooh/brightscript.vim"


filetype plugin indent on

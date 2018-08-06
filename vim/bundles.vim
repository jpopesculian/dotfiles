if &compatible
  set nocompatible
end

call plug#begin('~/.vim/plugged')

" Let Vundle manage Vundle
Plug 'gmarik/vundle'

" General
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'skwp/greplace.vim'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/loremipsum'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'thinca/vim-ref'
Plug 'vim-scripts/TaskList.vim'
Plug 'floobits/floobits-neovim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-db'
Plug 'tpope/vim-abolish'
Plug 'blindFS/vim-taskwarrior'

" linter
Plug 'sbdchd/neoformat'
" Plug 'Valloric/YouCompleteMe'
" Plug 'scrooloose/syntastic'
" Plug 'neomake/neomake'
Plug 'w0rp/ale'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'ternjs/tern_for_vim'
Plug 'othree/tern_for_vim_coffee'
Plug 'othree/jspc.vim'

" Javascript
" Plug 'pangloss/vim-javascript'
" Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'kchmck/vim-coffee-script'
" Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'
" Plug 'othree/yajs.vim'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
" JSON
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'

" HTML
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'

" CSS
Plug 'hail2u/vim-css3-syntax'
" Less
Plug 'groenewege/vim-less'

" Python
" Plug 'davidhalter/jedi-vim' ' trying out ycm instead
" Plug 'klen/python-mode'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'rhysd/vim-crystal'

" HAML
" (also contains sass)
Plug 'tpope/vim-haml'
" YAML
Plug 'ingydotnet/yaml-vim'
Plug 'chase/vim-ansible-yaml'

" Clojure
" Plug 'guns/vim-sexp'
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'guns/vim-clojure-static'
" Plug 'tpope/vim-leiningen'
" Plug 'tpope/vim-fireplace'
" Plug 'guns/vim-clojure-highlight'
" Plug 'junegunn/rainbow_parentheses.vim'

" Haskell
" Plug 'haskell.vim'
" Plug 'dag/vim2hs'

" Markdown / Writing
Plug 'reedes/vim-wordy'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'reedes/vim-pencil'
Plug 'jceb/vim-orgmode'

" Roku Brightscript
" Plug 'chooh/brightscript.vim'

" Go
Plug 'fatih/vim-go'
Plug 'nsf/gocode', {'rtp': 'nvim/'}

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" zeal
Plug 'KabbAmine/zeavim.vim'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}
    Plug 'carlitux/deoplete-ternjs'
else
    Plug 'Shougo/neocomplete.vim'
end

" fancy
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

call plug#end()

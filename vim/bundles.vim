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
" Plug 'vim-scripts/TaskList.vim'
Plug 'floobits/floobits-neovim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-db'
Plug 'tpope/vim-abolish'
" Plug 'blindFS/vim-taskwarrior'
Plug 'airblade/vim-rooter'
Plug 'metakirby5/codi.vim'

" linter
" Plug 'sbdchd/neoformat'
" Plug 'Valloric/YouCompleteMe'
" Plug 'scrooloose/syntastic'
" Plug 'neomake/neomake'
Plug 'w0rp/ale'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
" Plug 'ternjs/tern_for_vim'
" Plug 'othree/tern_for_vim_coffee'
Plug 'othree/jspc.vim'

" Javascript
" Plug 'pangloss/vim-javascript'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'kchmck/vim-coffee-script'
" Plug 'posva/vim-vue'
" Plug 'mxw/vim-jsx'
" Plug 'flowtype/vim-flow'
" Plug 'othree/yajs.vim'
" Plug 'othree/yajs.vim'
" Plug 'othree/es.next.syntax.vim'
" Plug 'Quramy/vim-js-pretty-template'

" JSON
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'
" Typescript
" Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'

" Dart
Plug 'dart-lang/dart-vim-plugin'

" HTML
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'

" CSS
Plug 'hail2u/vim-css3-syntax'
Plug 'hhsnopek/vim-sugarss'
" Less
Plug 'groenewege/vim-less'

" Python
" Plug 'plytophogy/vim-virtualenv'
Plug 'deoplete-plugins/deoplete-jedi'

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
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-highlight'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'venantius/vim-cljfmt'

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
Plug 'freitass/todo.txt-vim'
Plug 'junegunn/goyo.vim'
Plug 'rhysd/vim-grammarous'

" Roku Brightscript
" Plug 'chooh/brightscript.vim'

" Go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Solidity
Plug 'tomlion/vim-solidity'

" zeal
" Plug 'KabbAmine/zeavim.vim'

" nim
" Plug 'zah/nim.vim'

" lua
Plug 'tbastos/vim-lua'

" rust
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'rhysd/vim-wasm'
Plug 'racer-rust/vim-racer'

" JVM
Plug 'udalov/kotlin-vim'
Plug 'artur-shaik/vim-javacomplete2'

" capnp
Plug 'cstrahan/vim-capnp'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
else
    Plug 'Shougo/deoplete.vim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
end

" fancy
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

call plug#end()

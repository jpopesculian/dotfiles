set nocompatible " vi improved
set hidden
set encoding=utf-8

" Bootstrap this vimrc
source ~/.vim/bootstrap.vim

" Load vundle plugins
source ~/.vim/bundles.vim
" source ~/.vim/autoload/pathogen.vim

let g:deoplete#enable_at_startup = 1

" Colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax enable " source system syntax file
syntax on " use background setting for highlight
set t_Co=256 " always use 256 colors (FIXME doesnt degrade well)
fun! ToggleColor()
    if &background == "dark"
        set background=light
        colorscheme Tomorrow
    else
        set background=dark
        colorscheme hybrid
    endif
endf
set background=light
call ToggleColor() " set default to dark

" UI Config
set number " line numbers on
set relativenumber " note using plugin jeffkreeftmeijer/vim-numbertoggle
set showcmd " show incomplete commands at bottom right
set showmatch " briefly highlight matched bracket when pair completed
set ruler " display line and col numbers in bottom right
set wildmenu " tab complete in command line
set wildmode=list:longest,list:full
set lazyredraw " save some cycles: dont redraw during macros
set list listchars=tab:»·,trail:· " show trailing whitespace
set nofoldenable " dont like code folding
set colorcolumn=80 " draw line at 80 cols
set cursorline " highlight the line we are currently on

" Whitespace (should normally be overriden by local editorconfig)
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4

" Whitespace higlighting
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Windows
set splitright " Open new split panes to right
set splitbelow " and bottom, which feels more natural

" File writing
set nobackup
set nowritebackup
set noswapfile
set autoread
set autowriteall
autocmd FocusLost * silent! wa " write all on lost focus
autocmd TabLeave * silent! wa " autowriteall doesn't capture tab changing

" Undo
" set undofile
" set undolevels=1000 " max changes
" set undoreload=10000 " max lines saved on buffer reload
" set undodir=~/.vim/undodir
" if empty(glob(&undodir))
"     call system('mkdir ' . &undodir)
" endif

" Searching
set incsearch " Find the next match as we type the search
set ignorecase " Ignore case when searching...
set smartcase " ...unless we type a capital

" Other settings
set mouse=c " set to 'a' to use the mouse
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
set backspace=2 " help cygwin out with backspace
set formatoptions+=j " remove comment prefixes when joining lines
set formatoptions-=o " dont add comment prefix on o/O
set formatoptions-=r " dont add comment prefix on <cr>

" Non-leader mappings
map ; :
noremap ;; ,
noremap , ;
nnoremap q; q: " much easier to hit
command! Q q
nnoremap <F5> :e %<CR> " reload file
set pastetoggle=<F12>
" find selection in visual mode
vnoremap // y/<C-R>"<CR>
" add newline in normal mode
nnoremap <C-m> i<CR><esc>k:s/\s\+$//<CR><esc>$j

" Saving and Exiting
inoremap jk <esc>
" note maybe remove kj
inoremap kj <esc>:w<cr>
inoremap <C-d> <esc>:w<CR>:e %:p:h<CR>
inoremap <C-c> <esc>:x<CR>
nnoremap <C-c> :x<CR>
nnoremap <C-d> :w<CR>:e %:p:h<CR>

" navigate with alt keys
nmap <silent> <A-k> <C-w>j
nmap <silent> <A-j> <C-w>k
nmap <silent> <A-h> <C-w>h
nmap <silent> <A-l> <C-w>l


" Leader mappings (use :map <leader> to see all mappings in order)
let mapleader=" "
let maplocalleader="\\"

" White space
nnoremap <leader>S :%s/\s\+$//<CR>
nnoremap <leader><tab> :retab<CR>
nnoremap <Leader>wn :match ExtraWhitespace /^\s* \s*\<Bar>\s\+$/<CR>
nnoremap <Leader>wf :match<CR>

" quick comment
nnoremap <leader>cc :Commentary<CR>
vnoremap <leader>c :Commentary<CR>

" Organizing
vnoremap <leader>s :sort<CR>
nnoremap <leader>s {jV}k:sort<CR>

" Window mgmt
nnoremap <leader>t :tab split<CR>
nnoremap <leader>sv :vs<CR>
nnoremap <leader>sh :sp<CR>
nnoremap <leader>- :exe "resize " . (winheight(0) * 4/5)<CR>
nnoremap <leader>_ :exe "resize " . (winheight(0) * 5/4)<CR>
nnoremap <leader>= :exe "vertical resize " . (winwidth(0) * 4/5)<CR>
nnoremap <leader>+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>

" Tab mgmt
nnoremap <leader>[ :tabN<CR>
nnoremap <leader>] :tabn<CR>
nnoremap <leader>{ :tabm -1<CR>
nnoremap <leader>} :tabm +1<CR>
nnoremap <leader>T :tabc<CR>
nnoremap <leader>Q :tabo<CR>

" File nav
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>F :NERDTreeFind<CR>
nnoremap <leader>d :e %:p:h<CR>
nnoremap <leader>D :e .<CR>

" File search
set grepprg=ag " note using rking/ag.vim
nnoremap <leader>gc :Ag <c-r>=expand('<cword>'><cr>
nnoremap <leader>gg :Ag 
nnoremap <leader>gh :Ag --html 
nnoremap <leader>gj :Ag --js 
nnoremap <leader>gp :Ag --python 
nnoremap <leader>gr :Ag --ruby 
nnoremap <leader>gs :Ag --sass 

" Quick FZF
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>O :Files<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>E :History<CR>
nnoremap <leader>H :History:<CR>
nnoremap <leader>/ :History/<CR>

" Replace all
nnoremap <leader>r :%S/<c-r>=expand("<cword>")<cr>/
vnoremap <leader>r "sy:%S/<c-r>s/

" Replace in line
nnoremap <leader>lr :S/<c-r>=expand("<cword>")<cr>/

" Using fugitive
nnoremap <leader>cf :Gwrite<cr>:Gcommit<cr>
nnoremap <leader>cp :Gpush<cr>

" For vimdiff
nnoremap <leader>1 :diffget LOCAL<cr>
nnoremap <leader>2 :diffget BASE<cr>
nnoremap <leader>3 :diffget REMOTE<cr>

" Copy/pasting from system registers
noremap <leader>p "+

" Open file in browser
nnoremap <leader>co :!google-chrome '%'<CR>
" on macosx
nnoremap <leader>mo :!open '%'<CR>

" Edit/reload the vimrc file
nnoremap <leader>va :tabe ~/.dotfiles/vimrc<CR>:vsp ~/.dotfiles/vim/bundles.vim<CR><c-w>h
nnoremap <leader>ve :tabe ~/.dotfiles/vimrc<CR>
nnoremap <leader>vb :tabe ~/.dotfiles/vim/bundles.vim<CR>
nnoremap <leader>vs :so $MYVIMRC<CR>
nnoremap <leader>vw :w<CR>:so $MYVIMRC<CR>

" Using Plug
nnoremap <leader>vi :PlugClean<CR>:PlugInstall<CR>

" Task List
nnoremap <leader>v <Plug>TaskList

" Saving and Exiting
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><leader><leader>q :qall<CR>
noremap <leader><leader>q :q!<CR>

" Close the quickfix list and loc list
nnoremap <leader>cl :ccl <bar> lcl<cr>

" Run current file
nnoremap <leader>x :!./%<cr>
autocmd FileType clojure nnoremap <leader>x :%Eval<cr>
autocmd FileType lua nnoremap <leader>x :!lua5.3 %<cr>

" Tagbar
nnoremap <leader>l :TagbarToggle<CR>

" Reads and writes file as hexadump
nnoremap <leader>br :%!xxd<CR>
nnoremap <leader>bw :%!xxd -r<CR>

" Format with pencil
nnoremap <leader>b :Goyo<CR>

" Run ALE commands
nnoremap <leader>, :ALEFix<CR>
nnoremap <leader>? :ALEDetail<CR>

"Run a file
autocmd FileType python nnoremap <leader>! :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType rust nnoremap <leader>! :CargoRun<CR>

" Word wrapping
function! ToggleWrap()
    if &list
        setlocal wrap linebreak nolist
        noremap <buffer> <silent> j gj
        noremap <buffer> <silent> k gk
    else
        setlocal list
        silent! nunmap <buffer> j
        silent! nunmap <buffer> k
    endif
endfunction
noremap <F6> :call ToggleWrap()<cr>

" Writing txt files
function! TxtMode()
    call ToggleWrap()
    setlocal nonumber norelativenumber
    setlocal spell
endfunction
command! English call TxtMode()

set completeopt=longest,menuone,preview

" deoplete
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.javascript = [
"   \ 'tern#Complete',
"   \ 'jspc#omni'
" \]
" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
" let g:tern#command = ['tern']
" let g:tern#arguments = ['--persistent']

" autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" autocmd FileType typescript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
" or just disable the preview entirely
set completeopt-=preview

" Markdown Syntax Support
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" pandoc
let g:pandoc#command#latex_engine = 'pdflatex'
let g:pandoc#command#autoexec_command = 'Pandoc pdf --variable urlcolor=cyan'
command PandocWatch let g:pandoc#command#autoexec_on_writes = 1

" pencil
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" neomake
" let blacklisted_files = ['schema.rb', 'routes.rb', 'visit.rb', 'job.rb']
" autocmd! BufWritePost * if index(blacklisted_files, expand('%:t')) < 0 | Neomake
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_ruby_enabled_makers = ['reek', 'rubocop']

" ale
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
let g:ale_sign_warning = ''
let g:ale_sign_error = ''
let g:ale_linters = {
\   'c': ['clang', 'gcc'],
\   'go': ['gofmt', 'gobuild', 'golangserver'],
\   'python': ['flake8'],
\   'rust': ['cargo'],
\   'typescript': ['tsserver', 'tslint'],
\   'solidity': ['solhint', 'solium'],
\   'javascript': [],
\   'kotlin': [],
\   'lua': ['luac', 'luacheck']
\}
let g:ale_fixers = {
\   'typescript': ['prettier'],
\   'json': [],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'java': ['google_java_format'],
\   'rust': ['rustfmt']
\}
let g:ale_fix_on_save = 1
" \   'kotlin': ['kotlinc', 'ktlint', 'languageserver'],

" rust
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
" let g:ale_rust_cargo_clippy_options = '--warn clippy::pedantic'
let g:ale_rust_rustfmt_options = '--unstable-features --edition 2018'

let g:racer_cmd = "/home/julian/.cargo/bin/racer"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" lua
let g:ale_lua_luac_executable = "/usr/bin/luac5.3"

" c
let g:ale_c_parse_makefile = 1

" javascript
let g:javascript_plugin_jsdoc = 0
let g:javascript_plugin_flow = 0
let g:flow#autoclose = 0

" java
let g:ale_java_google_java_format_options = '--skip-removing-unused-imports'
let g:ale_kotlin_languageserver_executable = '/home/julian/opt/KotlinLanguageServer/server/build/install/server/bin/server'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" autoformat
" autocmd FileType javascript set formatprg=prettier\ --stdin\ --single-quote\
" let g:neoformat_try_formatprg = 1
" autocmd BufWritePre *.js if matchend(fnameescape(expand('%:p')), 'single-ops') < 0 | Neoformat

"easytags
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_autorecurse = 0

" govim
let g:go_bin_path = expand("~/.go/bin")

"ruby
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1

" python
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:ale_python_auto_pipenv = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_auto_pipenv = 1

" silver searcher

let g:ackprg = 'ag --vimgrep --smart-case'
" cnoreabbrev ag Ack
" cnoreabbrev aG Ack
" cnoreabbrev Ag Ack
" cnoreabbrev AG Ack

" devicons
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" tagbar
let g:tagbar_type_snippets = {
    \ 'ctagstype' : 'snippets',
    \ 'kinds' : [
        \ 's:snippets',
    \ ]
\ }
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
  \ }

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'go': ['/home/julian/.go/bin/go-langserver'],
    \ }

let g:rooter_patterns = ['build.gradle', '.git/', 'package.json', 'Cargo.toml']

" \ 'python': ['python3', '-m', 'pyls'],
" \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" js templates
" call jspretmpl#register_tag('gql', 'graphql')
" call jspretmpl#register_tag('md', 'markdown')
" autocmd FileType typescript JsPreTmpl html

" read jsrender templates as html
au BufReadPost *.jsr set syntax=html

" toggle search highlight with F3
nnoremap <F3> :set hlsearch!<CR>

" Extra config files " note: deprecate: move to .vim/autoload/
" execute pathogen#infect()
" call pathogen#helptags()

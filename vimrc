set nocompatible " vi improved
set encoding=utf-8

" Bootstrap this vimrc
source ~/.vim/bootstrap.vim

" Load vundle plugins
source ~/.vim/bundles.vim
source ~/.vim/autoload/pathogen.vim

" Colors
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
set undofile
set undolevels=1000 " max changes
set undoreload=10000 " max lines saved on buffer reload
set undodir=~/.vim/undodir
if empty(glob(&undodir))
    call system('mkdir ' . &undodir)
endif

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
nnoremap <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>

" Tab mgmt
nnoremap <leader>[ :tabN<CR>
nnoremap <leader>] :tabn<CR>
nnoremap <leader>{ :tabm -1<CR>
nnoremap <leader>} :tabm +1<CR>
nnoremap <leader>T :tabc<CR>

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
nnoremap <leader>r :%s/<c-r>=expand("<cword>")<cr>/
vnoremap <leader>r "sy:%s/<c-r>s/

" Replace in line
nnoremap <leader>lr :s/<c-r>=expand("<cword>")<cr>/

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

" Using vundle
nnoremap <leader>vi :PluginClean<CR>:PluginInstall<CR>

" Saving and Exiting
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><esc> :qall<CR>
noremap <leader><leader>q :q!<CR>

" Close the quickfix list and loc list
nnoremap <leader>cl :ccl <bar> lcl<cr>

" Run current file
nnoremap <leader>x :!./%<cr>

" Linters
nnoremap <leader>l :TagbarToggle<CR>

" Reads and writes file as hexadump
nnoremap <leader>br :%!xxd<CR>
nnoremap <leader>bw :%!xxd -r<CR>

"Run a python file
autocmd FileType python nnoremap <buffer>x :exec '!python' shellescape(@%, 1)<cr>

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

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
" or just disable the preview entirely
set completeopt-=preview

" pandoc
let g:pandoc#command#latex_engine = 'pdflatex'
let g:pandoc#command#autoexec_command = 'Pandoc pdf --variable urlcolor=cyan'
command PandocWatch let g:pandoc#command#autoexec_on_writes = 1

" powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" neomake
let blacklisted_files = ['schema.rb', 'routes.rb', 'visit.rb', 'job.rb']
autocmd! BufWritePost * if index(blacklisted_files, expand('%:t')) < 0 | Neomake

" javascript
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_makers = ['reek', 'rubocop']
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" autoformat
autocmd BufWritePre *.js if matchend(fnameescape(expand('%:p')), 'single-ops') < 0 | Neoformat

" govim
let g:go_bin_path = expand("~/.go/bin")

" silver searcher

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" read jsrender templates as html
au BufReadPost *.jsr set syntax=html

" toggle search highlight with F3
nnoremap <F3> :set hlsearch!<CR>

" Extra config files " note: deprecate: move to .vim/autoload/
execute pathogen#infect()
call pathogen#helptags()

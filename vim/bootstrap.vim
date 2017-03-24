" Determines if this is the first time vimrc has been loaded and if so
" installs dependencies.

fun! FirstRunOnEnter()
    PlugInstall
    source $MYVIMRC
    let oldpath = getcwd()
    execute "cd ../tern_for_vim"
    silent !npm install
    execute "cd " . oldpath
endf

let plug = $HOME . '/.vim/autoload/plug.vim'

if !filereadable(plug)
    call system('curl -fLo ' . plug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * :call FirstRunOnEnter()
endif

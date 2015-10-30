" Determines if this is the first time vimrc has been loaded and if so
" installs dependencies.

fun! FirstRunOnEnter()
    PluginInstall
    source $MYVIMRC
    let oldpath = getcwd()
    execute "cd " . $HOME . "/.vim/bundle/YouCompleteMe"
    " NOTE this need cmake to be installed
    silent !./install.sh
    execute "cd ../tern_for_vim"
    silent !npm install
    execute "cd " . oldpath
endf

let vdir = $HOME . '/.vim/bundle/vundle'

if !isdirectory(vdir)
    call system('mkdir -p ' . vdir)
    call system('git clone https://github.com/gmarik/Vundle.vim.git ' . vdir)
    autocmd VimEnter * :call FirstRunOnEnter()
endif

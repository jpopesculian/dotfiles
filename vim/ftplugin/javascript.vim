" Add spaces after function
nnoremap <buffer> <leader>f<space> :%s/function(/function (/g<cr>

" Change bracket notation to dot notation
nnoremap <buffer> cd f]xhxF[xr.

" Set up syntastic properly for local files
let g:syntastic_javascript_checkers=['jshint']
if filereadable('./.jslintrc')
    let g:syntastic_javascript_checkers=['jslint']
endif
if filereadable('./.jscsrc')
    add(g:syntastic_javascript_checkers, 'jscs')
endif

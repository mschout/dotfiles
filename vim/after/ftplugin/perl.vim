" consider : part of a keyword
set iskeyword+=:
set sw=4

fu! DoxyMethodHeader()
    let subname = substitute(getline('.'), 'sub\s\+\(\w\+\)\s\+.*$', '\1', "")
    let lines = [
        \ '## @method ' . subname . '()',
        \ '# '
        \]
    for text in lines
        :call append(line('.') - 1, text)
    endfor
    :call cursor(line('.') - len(lines), 12)
endf
nmap <Leader>dm :call DoxyMethodHeader()<CR>

fu! DoxyCMethodHeader()
    let subname = substitute(getline('.'), 'sub\s\+\(\w\+\)\s\+.*$', '\1', "")
    let lines = [
        \ '## @cmethod ' . subname . '()',
        \ '# '
        \]
    for text in lines
        :call append(line('.') - 1, text)
    endfor
    :call cursor(line('.') - len(lines), 13)
endf
nmap <Leader>dcm :call DoxyCMethodHeader()<CR>

nnoremap ,pt <ESC>:%! perltidy<CR>
vnoremap ,pt <ESC>:'<,'>! perltidy<CR>

set cindent
" default is: 0{,0},0),:,0#,!^F,o,O,e
set cinkeys=0{,0},!^F,o,O,e
set cinoptions=(1s

" ctrl-c ctrl-c to compile
nmap <C-c><C-c> :!perl -Wc %<CR>

" indent with tab/shift-tab
nmap <tab>   v>
nmap <s-tab> v<
vmap <tab>   >gv
vmap <s-tab> <gv

" some common abbreviations
abbr _s $self
abbr _perlbin #!/usr/bin/env perl

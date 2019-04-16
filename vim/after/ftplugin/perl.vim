" consider : part of a keyword
set iskeyword+=:
set sw=4

nnoremap ,pt <ESC>:%! perlbrew-env perltidy<CR>
vnoremap ,pt <ESC>:'<,'>! perlbrew-env perltidy<CR>

" sql formatter
nnoremap ,st <ESC>:%! pg_format -s 2<CR>
vnoremap ,st <ESC>:'<,'>! pg_format -s 2<CR>

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

" perl: add 'use' statement
"
" make sure you have
"   setlocal iskeyword=48-57,_,A-Z,a-z,:
" so colons are recognized as part of a keyword
function! PerlAddUseStatement()
    " get current package name, locally chaging iskeyword
    let l:save_iskeyword = &l:iskeyword
    setlocal iskeyword=48-57,_,A-Z,a-z,:
    let l:package = input('Package? ', expand('<cword>'))
    let l:iskeyword = l:save_iskeyword

    " skip if that use statement already exists
    if (search('^use\s\+'.l:package, 'bnw') == 0)
        " below the last use statement, except for some special cases
        let s:line = search('^use\s\+\(constant\|strict\|warnings\|parent\|base\|5\)\@!','bnw')
        " otherwise, below the ABSTRACT (see Dist::Zilla)
        if (s:line == 0)
            let s:line = search('^# ABSTRACT','bnw')
        endif
        " otherwise, below the package statement
        if (s:line == 0)
            let s:line = search('^package\s\+','bnw')
        endif
        " if there isn't a package statement either, put it below
        " the last use statement, no matter what it is
        if (s:line == 0)
            let s:line = search('^use\s\+','bnw')
        endif
        " if there are no package or use statements, it might be a
        " script; put it below the shebang line
        if (s:line == 0)
            let s:line = search('^#!','bnw')
        endif
        " if s:line still is 0, it just goes at the top
        call append(s:line, 'use ' . l:package . ';')
    endif
endfunction
nnoremap ,us :<C-u>call PerlAddUseStatement()<CR>

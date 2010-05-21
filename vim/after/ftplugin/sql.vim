set equalprg=~/perl5/bin/localenv\ sql-beautify

" add sql beautify support
vmap ,sb <ESC>:'<,'>! ~/perl5/bin/localenv sql-beautify<CR>
nmap ,sb <ESC>:%! ~/perl5/bin/localenv sql-beautify<CR>


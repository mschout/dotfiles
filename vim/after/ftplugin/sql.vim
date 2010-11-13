set equalprg=~/perl5/bin/localenv\ sql-beautify

" taglist spews errors about tags menu for sql files
let Tlist_Show_Menu=0

" add sql beautify support
vmap ,sb <ESC>:'<,'>! ~/perl5/bin/localenv sql-beautify<CR>
nmap ,sb <ESC>:%! ~/perl5/bin/localenv sql-beautify<CR>


set equalprg=sql-beautify

" add sql beautify support
vmap ,sb <ESC>:'<,'>! sql-beautify<CR>
nmap ,sb <ESC>:%! sql-beautify<CR>


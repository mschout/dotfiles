runtime! syntax/javascript.vim
unlet b:current_syntax

so <sfile>:p:h/tt2.vim
unlet b:current_syntax
" ???
"syn cluster htmlPreProc add=@tt2_top_cluster


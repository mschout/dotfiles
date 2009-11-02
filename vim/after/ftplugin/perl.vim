" consider : part of a keyword
set iskeyword+=:
set sw=4

inoremap <Leader>dcm ## @cmethod
inoremap <Leader>dm ## @method

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

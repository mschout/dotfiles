set shiftwidth=2
set tabstop=2
set expandtab

inoremap <Leader>iv <!--#include virtual="" --><Esc>b2hi
inoremap <Leader>odc <div class=""><Esc>hi
inoremap <Leader>cd </div>
cnoremap <Leader>nc :s/center//g

inoremap <Leader>js <script type="text/javascript"><CR></script><Esc>O<Tab>
inoremap <Leader>dv <div><CR></div><Esc>O<Tab>
inoremap <Leader>cl class=""<Esc>i

inoremap <Leader>tv <tmpl_var ><Esc>i

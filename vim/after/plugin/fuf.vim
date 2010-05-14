" mappings for fuf.vim. putting it here makes sure it is only mapped if
" fuf.vim is loaded
if !exists('g:loaded_fuf') || exists('g:did_fuf_mappings')
    finish
endif
let g:did_fuf_mappings = 1

let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400

nnoremap <leader>t :FufFile**/<CR>

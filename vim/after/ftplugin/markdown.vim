" change default table mode chars to be markdown compatible
let g:table_mode_corner_corner='|'
let g:table_mode_header_fillchar='='

" helper to convert selected markdown to redmine format textile and copy to the clipboard
function! ToRedmine()
  '<,'>w !markdown-to-redmine | pandoc -f gfm -t textile - | xclip -selection clipboard
endfunction

" <Leader>tr shortcut to copy to clipboard as redmine textile
vnoremap <silent> <Leader>tr :<C-U>call ToRedmine()<CR>

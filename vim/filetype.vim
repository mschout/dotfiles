" my private filetypes
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.tmpl setfiletype html
augroup END

au BufNewFile,BufRead *.tt2 setf tt2html

au BufNewFile,BufRead *.tt setf tt2html

:let b:tt2_syn_tags = '\[% %] <!-- -->'

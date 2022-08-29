function! RubocopAutocorrect()
  execute "Dispatch rubocop -a " . bufname("%")
endfunction

nmap <silent> <Leader>rc :call RubocopAutocorrect()<CR>

setlocal iskeyword+=?,!,$,=

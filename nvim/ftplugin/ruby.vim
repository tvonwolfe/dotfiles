function! RubocopAutocorrect()
  execute "!rubocop -a " . bufname("%")
endfunction

nmap <silent> <Leader>rc :call RubocopAutocorrect()<CR>

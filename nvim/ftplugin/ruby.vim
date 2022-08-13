function! RubocopAutocorrect()
  execute "!rubocop -a " . bufname("%")
endfunction


" automatically trim trailing whitespace.
autocmd BufWritePre *.rb :%s/\s\+$//e

nmap <silent> <Leader>rc :call RubocopAutocorrect()<CR>

highlight clear
if exists("syntax_on")
	syntax reset
endif

runtime colors/vividchalk.vim

let g:colors_name = "iammer"

" highlight lines in Sy and vimdiff etc.)
highlight DiffAdd           cterm=bold ctermbg=234 ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=234 ctermfg=167
highlight DiffChange        cterm=bold ctermbg=234 ctermfg=227

" highlight signs in Sy
highlight SignifySignAdd    cterm=bold ctermbg=0   ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=0   ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=0   ctermfg=227

highlight SignColumn		ctermbg=0

highlight CursorLine cterm=none ctermbg=235

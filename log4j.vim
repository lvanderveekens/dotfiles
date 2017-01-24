" A VIM syntax highlighter for log4j

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syntax match errorKeyword "\v.*ERROR.*"
syntax match warnKeyword "\v.*WARN.*"
syntax match debugKeyword "\v.*DEBUG.*"
syntax match traceKeyword "\v.*TRACE.*"
highlight errorKeyword ctermbg=red ctermfg=white 
highlight warnKeyword ctermbg=yellow ctermfg=black
highlight debugKeyword ctermbg=blue ctermfg=black

let b:current_syntax = "log4j"

"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/haml-compile.vim
"VERSION:  0.9
"LICENSE:  MIT

let s:save_cpo = &cpo
set cpo&vim

function! hamlcompile#Exe()
    let haml = expand('%:p')
    let html = expand('%:p:r').'.html'
    let er = system('haml '.haml.' '.html)
    let errors = []

    for e in split(er, "\n")
        let error = matchlist(e, '\v\C(.{-}) on line ([0-9]{-}): (.*)')

        if error != []
            call add(errors, s:errorline(haml, error[2], error[1], error[3]))
        endif
    endfor

    if errors != []
        setlocal errorformat=%f:%l:%m
        cgetexpr join(errors, "\n")
        copen
    else
        cclose
    endif
endfunction

function! s:errorline(file, line, type, txt)
    return a:file.':'.a:line.':[ '.a:type.' ] '.a:txt
endfunction

let &cpo = s:save_cpo

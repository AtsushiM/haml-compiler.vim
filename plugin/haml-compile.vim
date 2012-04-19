"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/haml-compile.vim
"VERSION:  0.9
"LICENSE:  MIT

if exists("g:loaded_haml_compile")
    finish
endif
let g:loaded_haml_compile = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:haml_compile_file")
    let g:haml_compile_file = ['haml']
endif

command! HamlCompileEdit call hamlcompile#Edit()
command! HamlCompileCreate call hamlcompile#Create()
command! HamlCompileTemplate call hamlcompile#Template()

" auto make
function! s:SetAutoCmd(files)
    if type(a:files) != 3
        let file = [a:files]
    else
        let file = a:files
    endif

    if file != []
        for e in file
            exec 'au BufWritePost *.'.e.' call hamlcompile#Exe()'
        endfor
    endif
    unlet file
    unlet s:SetAutoCmd
endfunction
au VimEnter * call s:SetAutoCmd(g:haml_compile_file)

let &cpo = s:save_cpo

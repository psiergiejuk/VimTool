
function! UpdateDateTime ()
        "Funkcja która poprawia date i czas zapisu w pliku
        let save_cursor = getpos(".")
        let date_num = search( "__date__ = " )
        let time_num = search( "__time__ = " )
        let date_line = getline( date_num )
        let time_line = getline( time_num )
        let date = strftime( "\"%d/%m/%Y\"" )
        let time = strftime( "\"%T\"" )
        let date_repl = substitute( date_line, "\".*\"", date, "g")
        let time_repl = substitute( time_line, "\".*\"", time, "g")
        call setline( date_num, date_repl)
        call setline( time_num, time_repl)
        call setpos('.', save_cursor)
        echo "Update date and time"
    return 1
endfunction

" from http://www.ibm.com/developerworks/linux/library/l-vim-script-3/index.html
" Table of completion specifications (a list of lists)...
let s:completions = []
" Function to add user-defined completions...
function! AddCompletion (left, right, completion, restore)
    call insert(s:completions, [a:left, a:right, a:completion, a:restore])
endfunction
let s:NONE = ""
" Table of completions...
"                    Left   Right    Complete with...       Restore
"                    =====  =======  ====================   =======
call AddCompletion(  '{',   s:NONE,  "  }\<LEFT>\<LEFT>",      0    )
call AddCompletion(  '\[',  s:NONE,  "  ]\<LEFT>\<LEFT>",      0    )
call AddCompletion(  '(',   s:NONE,  "  )\<LEFT>\<LEFT>",      0    )
call AddCompletion(  '<',   s:NONE,  "  >\<LEFT>\<LEFT>",      0    )
call AddCompletion(  "'",   s:NONE,  "'",                      1    )
call AddCompletion(  "'",   "'",     "\<TAB>"                  3    )
call AddCompletion(  '"',   s:NONE,  '"',                      1    )
call AddCompletion(  '"',   '"',     "\<TAB>"                  1    )
call AddCompletion(  '"""',   '"""', "\<CR>\<ESC>O\<TAB>",     0    )
" Implement smart completion magic...
function! SmartComplete ()
    " Remember where we parked...
    let cursorpos = getpos('.')
    let cursorcol = cursorpos[2]
    let curr_line = getline('.')

    " Special subpattern to match only at cursor position...
    let curr_pos_pat = '\%' . cursorcol . 'c'

    " Tab as usual at the left margin...
    if curr_line =~ '^\s*' . curr_pos_pat
        return "\<TAB>"
    endif

    " How to restore the cursor position...
    let cursor_back = "\<C-O>:call setpos('.'," . string(cursorpos) . ")\<CR>"

    " If a matching smart completion has been specified, use that...
    for [left, right, completion, restore] in s:completions
        let pattern = left . curr_pos_pat . right
        if curr_line =~ pattern
            " Code around bug in setpos() when used at EOL...
            if cursorcol == strlen(curr_line)+1 && strlen(completion)==1 
                let cursor_back = "\<LEFT>"
            endif

            " Return the completion...
            return completion . (restore ? cursor_back : "")
        endif
    endfor

    " If no contextual match and after an identifier, do keyword completion...
    if curr_line =~ '\k' . curr_pos_pat
        return "\<C-N>"

    " Otherwise, just be a <TAB>...
    else
        return "\<TAB>"
    endif
endfunction

" Remap <TAB> for smart completion on various characters...
inoremap <silent> <TAB>   <C-R>=SmartComplete()<CR>

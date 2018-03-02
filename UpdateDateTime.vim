
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
function! UpdateDateTimeAnsiC ()
        "Funkcja która poprawia date i czas zapisu w pliku
        let save_cursor = getpos(".")
        let date_num = search( "date: " )
        let time_num = search( "time: " )
        let date_line = getline( date_num )
        let time_line = getline( time_num )
        let date = strftime( "\: %d/%m/%Y" )
        let time = strftime( "\: %T" )
        let date_repl = substitute( date_line, "\: .*", date, "g")
        let time_repl = substitute( time_line, "\: .*", time, "g")
        call setline( date_num, date_repl)
        call setline( time_num, time_repl)
        call setpos('.', save_cursor)
        echo "Update date and time"
    return 1
endfunction

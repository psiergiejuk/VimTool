"

set backspace=indent,eol,start
set sw=4
set expandtab
set number
set softtabstop=4
set hlsearch
set ruler
colorscheme darkblue
syntax on
"!!! PLEASE UPDATE THE PATH !!!
set backupdir=/var/backup/
map <F8> :tabprevious<cr>
map <F9> :tabnext<cr>
map <F10> :wincmd w<cr>


"!!! PLEASE UPDATE THE PATH !!!
source /home/siergiej/work/git_repo/VimTool/UpdateDateTime.vim
autocmd BufWritePre *.py silent! call UpdateDateTime()
autocmd BufWritePre *.c silent! call UpdateDateTimeAnsiC()
autocmd BufWritePre *.h silent! call UpdateDateTimeAnsiC()
"autocmd BufWritePre *.py silent! ! git add <afile>
au FileType tex setlocal tw=78

"!!! PLEASE UPDATE THE PATH !!!
function! MyAddPythonClassTemplate()
    r/home/siergiej/work/git_repo/VimTool/python_template_class.py
endfunction
function! MyAddPythonFileTemplate()
    r/home/siergiej/work/git_repo/VimTool/python_template_file.py
endfunction

"nmap ^B :call Class()<CR>
"nmap ^b :call PythonFile()<CR>:


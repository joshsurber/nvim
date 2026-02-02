" indent/x12.vim
" X12 / EDI indentation entrypoint

setlocal indentexpr=v:lua.require'x12.indent'.get_indent(v:lnum)
setlocal autoindent
setlocal nosmartindent
setlocal nocindent
setlocal indentkeys=o,O,*<Return>

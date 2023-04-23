declare-option str snippet_dir
set-option global snippet_dir '~/.local/share/kak-snippets/'

define-command snippet-insert -params 1 -menu -shell-script-candidates %{
    fd --type file . ~/.local/share/kak-snippets/$kak_opt_filetype/ | awk -F '/' '{print $NF}'
} %{
    execute-keys -save-regs '' "|cat ~/.local/share/kak-snippets/%opt{filetype}/%arg{1}<ret>"
    try %{
        execute-keys -save-regs '' 's\$\d<ret>)<space>'
        set-register / '\$\d'
    }
} -docstring "poor man's snippets"

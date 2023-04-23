# modeline  -------------------------------------------------------------

declare-option str modeline_lsp_status
declare-option str modeline_git_branch

hook global WinCreate .* %{
    hook window NormalIdle .* %{ evaluate-commands %sh{
        status=""
        if [ "$kak_opt_lsp_diagnostic_error_count" -ne 0 ]; then
            status=$(printf " *%s" "$kak_opt_lsp_diagnostic_error_count")
        fi
        if [ "$kak_opt_lsp_diagnostic_warning_count" -ne 0 ]; then
            status=$(printf "$status !%s" "$kak_opt_lsp_diagnostic_warning_count")
        fi
        printf 'set window modeline_lsp_status %%{%s}' "$status"
    } }
}

hook global WinCreate .* %{ evaluate-commands %sh{
    branch=$(cd "$(dirname "${kak_buffile}")" && git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "${branch}" ]; then
        printf 'set window modeline_git_branch %%{[%s] }' "${branch}"
    fi
} }


declare-option -hidden str lsp_modeline_progress ""
define-command -hidden -params 6 -override lsp-handle-progress %{
    set-option global lsp_modeline_progress %sh{
        # if ! "$6"; then
            echo "$2${5:+" ($5%)"}${4:+": $4"}"
        # fi
    }
}

set global modelinefmt '%opt{lsp_modeline_progress} {yellow}%opt{modeline_lsp_status}{default} '
set -add global modelinefmt '{default}%val{bufname} [%opt{filetype}] '
set -add global modelinefmt '{default}%val{cursor_line}:%val{cursor_char_column}/%val{buf_line_count}{default} {{mode_info}} {{context_info}}'
set -add global modelinefmt '{Whitespace} | {default}%sh{pwd | sed "s|^$HOME|~|" | sed "s|~/projects|~/p|"} %opt{modeline_git_branch}{meta}%val{client}{default}@{+b@meta}%val{session}'

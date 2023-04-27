define-command -override wezterm-terminal-horizontal -params .. -docstring '
    wezterm-terminal-horizontal <program> [<arguments>]: create new horizontal WezTerm pane' \
%{
    nop %sh{
        WEZTERM_PANE=$kak_client_env_WEZTERM_PANE wezterm cli split-pane --cwd "$PWD" --right "${@:-$SHELL}"
    }
}
complete-command wezterm-terminal-horizontal shell

define-command -override wezterm-terminal-vertical -params .. -docstring '
    wezterm-terminal-vertical <program> [<arguments>]: create new vertical WezTerm pane' \
%{
    nop %sh{
        WEZTERM_PANE=$kak_client_env_WEZTERM_PANE wezterm cli split-pane --cwd "$PWD" --bottom "${@:-$SHELL}"
    }
}
complete-command wezterm-terminal-vertical shell

define-command -override wezterm-terminal-panel -params .. -docstring '
    wezterm-terminal-panel <program> [<arguments>]: create new narrow WezTerm pane' \
%{
    nop %sh{
        WEZTERM_PANE=$kak_client_env_WEZTERM_PANE wezterm cli split-pane --cwd "$PWD" --right --cells 40 "${@:-$SHELL}"
    }
}
complete-command wezterm-terminal-panel shell

define-command -override wezterm-terminal-popup -params .. -docstring '
    wezterm-terminal-popup <program> [<arguments>]: create new bottom top-level WezTerm pane' \
%{
    nop %sh{
        WEZTERM_PANE=$kak_client_env_WEZTERM_PANE wezterm cli split-pane --cwd "$PWD" --bottom --cells 20 "${@:-$SHELL}"
    }
}
complete-command wezterm-terminal-popup shell

define-command -override wezterm-terminal-tab -params .. -docstring '
    wezterm-terminal-tab <program> [<arguments>]: create new WezTerm tab' \
%{
    nop %sh{
        WEZTERM_PANE=$kak_client_env_WEZTERM_PANE wezterm cli spawn --cwd "$PWD" "${@:-$SHELL}"
    }
}
complete-command wezterm-terminal-tab shell

define-command -override wezterm-terminal-window -params .. -docstring '
    wezterm-terminal-window <program> [<arguments>]: create new WezTerm window' \
%{
    nop %sh{
        WEZTERM_PANE=$kak_client_env_WEZTERM_PANE wezterm cli spawn --cwd "$PWD" --new-window "${@:-$SHELL}"
    }
}
complete-command wezterm-terminal-window shell

# Hooks
# WezTerm detection
# Ensure that we're running on WezTerm
remove-hooks global wezterm-detection
hook -group wezterm-detection global ClientCreate '.*' %{
    trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
}

# WezTerm integration
remove-hooks global wezterm-integration
hook -group wezterm-integration global User 'TERM_PROGRAM=WezTerm' %{
    alias global terminal wezterm-terminal-horizontal
    alias global terminal-horizontal wezterm-terminal-horizontal
    alias global terminal-vertical wezterm-terminal-vertical
    alias global terminal-panel wezterm-terminal-panel
    alias global terminal-tab wezterm-terminal-tab
    alias global terminal-window wezterm-terminal-window
    alias global terminal-popup wezterm-terminal-popup
}

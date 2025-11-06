# VARIABLES

set -gx OS (uname -s)
set -gx DENO_INSTALL $HOME/.deno
set -gx BUN_INSTALL $HOME/.bun
set -gx PNPM_HOME /Users/kkga/Library/pnpm
set -gx FZF_DEFAULT_COMMAND 'fd --type=file'
set -gx FZF_DEFAULT_OPTS '--layout=reverse --height=50% --preview-window=bottom:50%,border-top --inline-info --color=prompt:3,header:7,info:7,pointer:14:bold,marker:4,hl:4,hl+:12:,fg+:15,bg+:235'
set -gx EDITOR hx
set -gx VISUAL code
set -gx BAT_THEME ansi
set -gx BAT_STYLE plain

# PATH

fish_add_path /opt/homebrew/bin \
    /opt/homebrew/sbin \
    "$HOME/.yarn/bin" \
    "$DENO_INSTALL/bin" \
    "$BUN_INSTALL/bin" \
    "$HOME/.cargo/bin" \
    "$PNPM_HOME"
fish_add_path -m "$HOME/.local/bin"

# ABBREVIATIONS

abbr g git
abbr pn pnpm
abbr pnx pnpx
abbr cm chezmoi
abbr notes "zk -W ~/notes e"
abbr notes-retool "zk -W ~/retool-notes e"
abbr e hx
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat="bat"
alias lg="lazygit"
alias cp="cp -iv"
alias mv="mv -iv"
# alias rm="rm -i"
# alias npm="pnpm"
# alias npx="pnpx"

# COLORS

set fish_color_autosuggestion normal --dim
set fish_color_cancel -r
set fish_color_command --bold
set fish_color_comment brmagenta
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end brmagenta
set fish_color_error brred
set fish_color_escape brcyan
set fish_color_history_current --bold
set fish_color_host normal
set fish_color_match --background=brblue
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param brblue
set fish_color_quote yellow
set fish_color_redirection bryellow
set fish_color_search_match bryellow '--background=brblack'
set fish_color_selection white --bold '--background=brblack'
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path --underline
set fish_pager_color_prefix normal
set fish_pager_color_completion normal
set fish_pager_color_description white
set fish_pager_color_selected_background -r

# INTERACTIVE

if status --is-interactive
    set fish_greeting
    set -g hydro_symbol_prompt '>'
    bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
    bind \ej 'cd $(zoxide query -i); commandline -f repaint'
    zoxide init fish --cmd j | source
    direnv hook fish | source
end

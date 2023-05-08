# VARIABLES

set -gx OS (uname -s)
set -gx DENO_INSTALL $HOME/.deno
set -gx PNPM_HOME /Users/kkga/Library/pnpm
set -gx FZF_DEFAULT_COMMAND 'fd --type=file'
set -gx FZF_DEFAULT_OPTS '--layout=reverse --height=50% --preview-window=bottom:50%,border-top --inline-info --color=prompt:3,header:7,info:7,pointer:14:bold,marker:4,hl:4,hl+:12:,fg+:15,bg+:235'
set -gx EDITOR hx
set -gx VISUAL $EDITOR
set -gx ZK_NOTEBOOK_DIR $HOME/notes
set -gx BAT_THEME ansi
set -gx BAT_STYLE plain
if [ $OS = Linux ]
    set -gx SSH_AUTH_SOCK "/run/user/$(id -u)/gcr/ssh"
else if [ $OS = Darwin ]
    set -gx LDFLAGS -L/opt/homebrew/opt/unixodbc/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/unixodbc/include
    set -gx CPPFLAGS -I/opt/homebrew/opt/openjdk/include
    set -gx KAKOUNE_POSIX_SHELL /opt/homebrew/bin/dash
    set -gx JAVA_HOME (/usr/libexec/java_home)
end

# PATH

if [ $OS = Darwin ]
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
    fish_add_path /opt/homebrew/opt/icu4c/bin
    fish_add_path /opt/homebrew/opt/icu4c/sbin
    fish_add_path /usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin
    fish_add_path /usr/local/opt/openssl@1.1/bin
    fish_add_path /opt/homebrew/opt/tcl-tk/bin
    fish_add_path /opt/homebrew/opt/openjdk/bin
end
fish_add_path \
    "$HOME/.yarn/bin" \
    "$DENO_INSTALL/bin" \
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
alias ls="exa --color=auto --group-directories-first -h"
alias la="exa -alh"
alias cat="bat"
alias lg="lazygit"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -i"

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
    set -g hydro_symbol_prompt '»'
    bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
    bind \ej 'cd $(zoxide query -i); commandline -f repaint'
    zoxide init fish --cmd j | source
    direnv hook fish | source
    atuin init fish | source
    fnm env --use-on-cd --version-file-strategy recursive | source
end

set -gx OS (uname -s)
set -gx GOPATH $HOME/.local/go
set -gx DENO_INSTALL $HOME/.deno
set -gx PNPM_HOME /Users/kkga/Library/pnpm
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PNPM_HOME /Users/kkga/Library/pnpm
set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_COMMAND 'fd --type=file'
set -gx FZF_DEFAULT_OPTS '--layout=reverse --height=50% --preview-window=bottom:50%,border-top --inline-info --color=prompt:3,header:7,info:7,pointer:14:bold,marker:4,hl:4,hl+:12:,fg+:15,bg+:235'
set -gx EDITOR hx
set -gx VISUAL $EDITOR
set -gx TDX_PATH $HOME/.local/share/calendars/mailbox
set -gx TDX_LIST_OPTS '-g tag'
set -gx TDX_ADD_OPTS '-l MzM'
set -gx KKS_DEFAULT_SESSION default
set -gx KKS_USE_GITDIR_SESSIONS 1
set -gx ZK_NOTEBOOK_DIR $HOME/notes
set -xg BAT_THEME ansi
# set -gx DFT_DISPLAY inline

if [ $OS = Linux ]
    set -gx XBPS_DISTDIR $HOME/.void-packages
    set -gx WEBKIT_USE_SINGLE_WEB_PROCESS 1
    set -gx TERMINAL term
    set -gx TERMCMD term
    set -gx DMENU 'fuzzel --dmenu'
    set -gx BROWSER browser
    set -gx SSH_AUTH_SOCK "/run/user/$(id -u)/gcr/ssh"
else if [ $OS = Darwin ]
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
    fish_add_path /opt/homebrew/opt/icu4c/bin
    fish_add_path /opt/homebrew/opt/icu4c/sbin
    fish_add_path /usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin
    fish_add_path /usr/local/opt/openssl@1.1/bin
    fish_add_path /opt/homebrew/opt/tcl-tk/bin
    fish_add_path /opt/homebrew/opt/openjdk/bin
    set -gx LDFLAGS -L/opt/homebrew/opt/unixodbc/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/unixodbc/include
    set -gx CPPFLAGS -I/opt/homebrew/opt/openjdk/include
    set -gx KAKOUNE_POSIX_SHELL /opt/homebrew/bin/dash
    set -gx JAVA_HOME (/usr/libexec/java_home)
end

fish_add_path \
    "$HOME/.yarn/bin" \
    "$DENO_INSTALL/bin" \
    "$GOPATH/bin" \
    "$BUN_INSTALL/bin" \
    "$HOME/.cargo/bin" \
    "$PNPM_HOME"

fish_add_path -m "$HOME/.local/bin"

if status --is-interactive
    set fish_greeting
    set -g hydro_symbol_prompt '»'
    bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
    bind \ej 'cd $(zoxide query -i); commandline -f repaint'
    source $__fish_config_dir/abbr.fish
    source $__fish_config_dir/colors.fish
    zoxide init fish --cmd j | source
    direnv hook fish | source
    fnm env --use-on-cd --version-file-strategy recursive | source
end

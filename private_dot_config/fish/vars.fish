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

if [ $OS = Linux ]
    set -gx SSH_AUTH_SOCK "/run/user/$(id -u)/gcr/ssh"
else if [ $OS = Darwin ]
    set -gx LDFLAGS -L/opt/homebrew/opt/unixodbc/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/unixodbc/include
    set -gx CPPFLAGS -I/opt/homebrew/opt/openjdk/include
    set -gx KAKOUNE_POSIX_SHELL /opt/homebrew/bin/dash
    set -gx JAVA_HOME (/usr/libexec/java_home)
end
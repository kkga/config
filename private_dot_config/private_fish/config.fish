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

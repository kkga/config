# generic hooks ---------------------------------------------------------------

hook global WinCreate ^[^*]+$ %{editorconfig-load}

hook global BufOpenFile  .* %{ modeline-parse }
hook global BufWritePre  .* %{ try %{ format-buffer } }
hook global BufWritePre  .* %{ try %{ lsp-formatting-sync } }
hook global BufWritePre  .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }
hook global BufWritePost .* %{ try %{ lint } }

# cd into current-buffer dir or git dir on file open
hook global WinDisplay   .* %{
  evaluate-commands %sh{
    cd "$(dirname "$kak_buffile")" || return
    project_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
    [ -n "$project_dir" ] && dir="$project_dir" || dir="${PWD%/.git}"
    printf "cd %%{%s}\n" "$dir"
  }
}

hook global KakEnd .* lsp-exit

# recent files -------------------------------------------------------------

hook global BufCreate [^*].* %{
  nop %sh{
    mru=~/.cache/kak-mru
    echo "$kak_buffile" | awk '!seen[$0]++' - "$mru" | sponge "$mru"
  }
}

# filetype hooks ---------------------------------------------------------------

hook global WinSetOption filetype=go %{
  lsp-init
  set-option buffer formatcmd 'gofumpt -extra'
  set-option buffer lintcmd 'revive'
}

hook global WinSetOption filetype=zig %{
  lsp-init
  set-option buffer formatcmd 'zig fmt --stdin'
  set-option global lsp_server_configuration zls.zig_lib_path="/usr/lib/zig"
  set-option -add global lsp_server_configuration zls.warn_style=true
  set-option -add global lsp_server_configuration zls.enable_semantic_tokens=true
}

hook global WinSetOption filetype=(svelte|html|css|yaml|toml) %{
  # lsp-init
  set-option buffer formatcmd "prettier --plugin-search-dir=. --stdin-filepath=%val{buffile}"
}

hook global WinSetOption filetype=css %{
  set-option buffer lintcmd "stylelint -f unix"
}

hook global WinSetOption filetype=(c|cpp) %{
  set-option buffer lintcmd "clang-tidy %val{buffile}"
}

hook global WinSetOption filetype=(javascript|typescript) %{
  lsp-init
  set-option buffer formatcmd "deno fmt -"
}

hook global WinSetOption filetype=json %{
  lsp-init
  set-option buffer formatcmd "deno fmt --ext json -"
}

hook global WinCreate (.*/)?TODO %{ set buffer filetype todo }
hook global WinSetOption filetype=todo %{
  add-highlighter buffer/ regex '^[A-Z0-9 ]+:$' 0:yellow+b
}
hook global WinSetOption filetype=(markdown|todo) %{
  require-module todo
  set-option buffer lintcmd "vale --ext .md --no-wrap --output line --config ~/.config/vale/vale.ini"
  set-option buffer formatcmd "deno fmt --ext md -"
  map buffer normal <ret> ': todo-toggle<ret>' -docstring "toggle checkbox"
  add-highlighter buffer/ regex '\[ \]' 0:blue+b
  add-highlighter buffer/ regex '\[x\]' 0:comment
}

hook global WinSetOption filetype=lua %{
  set-option buffer formatcmd "stylua -"
}

hook global WinSetOption filetype=sh %{
  set-option buffer formatcmd 'shfmt -ci -sr'
}

hook global WinSetOption filetype=fish %{
  set-option buffer formatcmd 'fish_indent'
}

hook global WinSetOption filetype=gdscript %{
  lsp-init
  set-option buffer formatcmd "gdformat -"
}

# hook global WinSetOption filetype=clojure %{
#   set-option buffer formatcmd "joker --format -"
#   set-option buffer lintcmd "clj-kondo --lint -"
# }

hook global WinCreate .*\.astro %{
  set buffer filetype html
}

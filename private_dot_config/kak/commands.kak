# selections -------------------------------------------------------------------

define-command -override -hidden search-next-word -docstring 'search next word' %{
  execute-keys 'h/\W\w<ret><a-i>w'
}

define-command -override select-next-word -docstring 'select next word' %{
  evaluate-commands -itersel %{
    hook -group select-next-word -always -once window User "%val{selection_desc}" %{
      search-next-word
    }
  try %{
    execute-keys '<a-i>w'
    trigger-user-hook "%val{selection_desc}"
  } catch %{
    search-next-word
  }
    remove-hooks window select-next-word
  }
}

define-command select-highlights -docstring 'select all occurrences of current selection' %{
  execute-keys '"aZ*%s<ret>"bZ"az"b<a-z>a'
}

# select word under cursor and put it to / register
define-command word-auto-select -hidden -params 1 -docstring 'auto-select a word under cursor' %{
  try %{ evaluate-commands %sh{
    if echo "$kak_selections_desc" | grep -Eq '^(([0-9]+)\.([0-9]+),\2\.\3:?)+$'; then
      echo execute-keys '<a-i>w<ret>'
    fi
  } }
  execute-keys -save-regs '' -with-hooks %arg{1}
}

# single command for grep-next/prev matches ------------------------------------
# https://discuss.kakoune.com/t/single-command-for-grep-next-match-in-similar-buffers-lsp-make-find/1215

declare-option -hidden str my_grep_buffer

hook -group my global WinDisplay \
  \*(?:grep|find|make|references|diagnostics|implementations|symbols|cargo)\* %{
  set-option global my_grep_buffer %val{bufname}
}

define-command -override my-grep-next-match \
    -docstring 'Jump to the next match in a grep-like buffer' %{
    evaluate-commands -try-client %opt{jumpclient} %{
        buffer %opt{my_grep_buffer}
        execute-keys "<a-l> /^[^:\n]+:\d+:<ret>"
        grep-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{
        buffer %opt{my_grep_buffer}
        execute-keys gg %opt{grep_current_line}g
    }}
}

define-command -override my-grep-prev-match \
    -docstring 'Jump to the previous match in a grep-like buffer' %{
    evaluate-commands -try-client %opt{jumpclient} %{
        buffer %opt{my_grep_buffer}
        execute-keys "g<a-h> <a-/>^[^:\n]+:\d+:<ret>"
        grep-jump
    }
    try %{ evaluate-commands -client %opt{toolsclient} %{
        buffer %opt{my_grep_buffer}
        execute-keys gg %opt{grep_current_line}g
    }}
}

# lsp snippets ----------------------------------------------------------------

define-command -hidden insert-c-j %{
  try %{
    lsp-snippets-select-next-placeholders
    exec '<a-;>d'
  } catch %{
    exec -with-hooks '<c-n>'
  }
}

# misc ----------------------------------------------------------------

# define-command edit-kakrc %{ e ~/.config/kak/kakrc }

define-command comment-line-or-block %{
  try %{
    comment-line
  } catch %{
    comment-block
  }
}

define-command insert-date -override %{
  execute-keys -draft "|date +'%%a, %%d %%b %%Y'<ret>"
} -docstring 'insert current date'

# folding -------------------------------------------------------------

declare-option range-specs folded_ranges
addhl global/folded_ranges replace-ranges folded_ranges

define-command fold-selections -override %{
  eval -itersel %{
    set -add window folded_ranges "%val[selection_desc]|{Whitespace}────────────────────────────────────────────────────────────────────────────────"
  }
}

define-command fold-clear -override %{
  set window folded_ranges %val[timestamp]
}

alias global fold fold-selections

# file picker -----------------------------------------------------------------

define-command find-files -docstring 'find in git files or all files' %{
  evaluate-commands %sh{
    if git rev-parse 2>/dev/null; then
      printf "kks-connect terminal-popup kks-git-files"
    else
      printf "kks-connect terminal-popup kks-files %val{client_end_PWD}"
    fi
  }
}

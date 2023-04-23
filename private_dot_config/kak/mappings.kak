# normal -------------------------------------------------------------

# i don't have ; on the base keyboard layer
map global normal "'"       ';'

# work around some weird defaults
map global normal a         'li'

# repurpose visual mode keys for object selection
map global normal <a-v>     'v'
map global normal <a-V>     'V'
map global normal v         '<a-i>'
map global normal V         '<a-a>'

# search case-insensitive
map global normal /         '/(?i)'
map global normal ?         '?(?i)'
map global normal <a-/>     '<a-/>(?i)'
map global normal <a-?>     '<a-?>(?i)'

# navigate by paragraphs
map global normal <c-n>     ']pj;x<a-;>'
map global normal <c-p>     '[p;x<a-;>'
map global normal <c-j>     ']pj;x<a-;>'
map global normal <c-k>     '[p;x<a-;>'

# navigate errors
map global normal <left>  ': lsp-find-error --previous --include-warnings<ret>: lsp-hover<ret>'
map global normal <right> ': lsp-find-error --include-warnings<ret>: lsp-hover<ret>'

# ciao macros: q, w and e are now together
map global normal q         'b'
map global normal Q         'B'
map global normal <a-q>     '<a-b>'
map global normal w         ': select-next-word<ret>'

# format & comment
map global normal =         ': format<ret>'
map global normal '#'       ': comment-line<ret>'
map global normal <a-#>     ': comment-block<ret>'
map global normal <c-/>     ': comment-line-or-block<ret>'

# selection
map global normal *         ': word-auto-select *<ret>'
map global normal <a-*>     ': word-auto-select <lt><a-*><ret>'
map global normal S         ': enter-select-mode<ret>'
map global normal Y         ': enter-user-mode -lock mirror<ret>'

# save/quit/close
map global normal '<c-w>'   ': write<ret>'
map global normal '<c-q>'   ': quit<ret>'
map global normal '<c-x>'   ': delete-buffer<ret>'
map global normal '<c-X>'   ': delete-buffer!<ret>'

# repeat last command
map global normal <c-.>     ':<ret>'

# goto ------------------------------------------------------------------------

map global goto <c-f>       '<esc>: prompt -shell-script-candidates %{ fd --type f --hidden --no-ignore --exclude .git --exclude target  } file: %{ edit %val{text} }<ret>' -docstring "file"
map global goto <c-g>       '<esc>: buffer *grep*<ret>' -docstring 'grep buffer'
map global goto <p>         '<esc>: my-grep-prev-match<ret>' -docstring 'grep prev match'
map global goto <n>         '<esc>: my-grep-next-match<ret>' -docstring 'grep next match'
map global goto <b>         '<esc>: buffer-switcher<ret>'

# anchor ------------------------------------------------------------------------

declare-user-mode anchor
map global normal ';'       'Z: enter-user-mode -lock anchor<ret>'
map global anchor a         '<a-;>;'     -docstring 'reduce to anchor'
map global anchor c         ';'          -docstring 'reduce to cursor'
map global anchor f         '<a-;>'      -docstring 'flip cursor and anchor'
map global anchor h         '<a-:><a-;>' -docstring 'ensure anchor after cursor'
map global anchor l         '<a-:>'      -docstring 'ensure cursor after anchor'
map global anchor s         '<a-S>'      -docstring 'select cursor and anchor'
map global anchor u         'z'          -docstring 'restore selection'

# insert -------------------------------------------------------------

map global insert <c-n> "<a-;>: insert-c-n<ret>" -docstring "jump to next lsp snippet placeholder"

# Minimal set of readline mappings
# https://github.com/lenormf/out-of-the-box/blob/master/oob.kak
map global insert <c-a>     '<a-;>gh'                                -docstring "move the cursor to the start of the line"
map global insert <c-e>     '<esc>glli'                              -docstring "move the cursor to the end of the line"
map global insert <c-d>     '<a-;>c'                                 -docstring "delete the character under the anchor"
map global insert <c-u>     '<esc>h<a-h>c'                           -docstring "delete from the cursor to the start of the line"
map global insert <c-k>     '<esc><a-l>c'                            -docstring "delete from the cursor to the end of the line"
map global insert <a-d>     '<esc>ec'                                -docstring "delete until the next word boundary"
map global insert <c-w>     '<esc>bc'                                -docstring "delete until the previous word boundary"
map global insert <c-y>     '<esc>Pi'                                -docstring "paste before the cursor"

# indentation
map global insert <tab>     '<a-;><a-gt>'
map global insert <s-tab>   '<a-;><lt>'

# autocomplete with tab
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n> }
hook global InsertCompletionHide .* %{ map window insert <tab> '<a-;><a-gt>' }
hook global InsertCompletionShow .* %{ map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ map window insert <s-tab> '<a-;><lt>' }

# terminal ---------------------------------------------------------

declare-user-mode terminal
map global normal   <c-t>   ': enter-user-mode terminal<ret>'
map global terminal <ret>   ': kks-connect terminal<ret>'            -docstring 'normal'
map global terminal <tab>   ': kks-connect terminal-panel<ret>'      -docstring 'panel'
map global terminal <p>     ': kks-connect terminal-popup<ret>'      -docstring 'popup'
map global terminal <h>     ': kks-connect terminal-horizontal<ret>' -docstring 'horizontal'
map global terminal <v>     ': kks-connect terminal-vertical<ret>'   -docstring 'vertical'

# user ---------------------------------------------------------------

# system clipboard
evaluate-commands %sh{
  case $(uname) in
    Linux) copy="wl-copy"; paste="wl-paste --no-newline" ;;
    Darwin) copy="pbcopy"; paste="pbpaste" ;;
  esac
  printf "map global user -docstring 'clip-paste (after)'   p '<a-!>%s<ret>'\n" "$paste"
  printf "map global user -docstring 'clip-paste (before)'  P '!%s<ret>'\n" "$paste"
  printf "map global user -docstring 'clip-yank'            y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection clipboard}<ret>'\n" "$copy"
  printf "map global user -docstring 'clip-replace'         R '|%s<ret>'\n" "$paste"
}

map global user t ': lsp-selection-range<ret>'                   -docstring 'tree.. (lock)'
map global user c ': enter-user-mode cd<ret>'                    -docstring 'CD..'
map global user v ': kks-connect terminal-popup lazygit<ret>'    -docstring 'vcs'
map global user d ': kks-connect terminal-panel kks-lf<ret>'     -docstring 'dir'
map global user f ': enter-user-mode pick<ret>'                  -docstring 'pick mode'
# map global user f ': find-files<ret>'                            -docstring 'files'
map global user f ': kks-connect terminal-popup kks-zf<ret>'     -docstring 'files'
map global user F ': kks-connect terminal-popup kks-files -I -H<ret>' -docstring 'all files'
map global user b ': kks-connect terminal-popup kks-buffers<ret>' -docstring 'buffers'
map global user / ': kks-connect terminal-popup kks-grep<ret>'   -docstring 'files by content'
map global user l ': kks-connect terminal-popup kks-lines<ret>'  -docstring 'lines in buffer'
map global user r ': kks-connect terminal-popup kks-mru<ret>'    -docstring 'recent files'

# lsp ----------------------------------------------------------------

map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'

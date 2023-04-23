set-option global lsp_diagnostic_line_error_sign '▎'
set-option global lsp_diagnostic_line_warning_sign '▎'
set-option global lsp_diagnostic_line_hint_sign "A"
set-option global lsp_diagnostic_line_info_sign "i"
set-option global lsp_hover_anchor true
set-option global lsp_auto_highlight_references true
set-option global lsp_hover_max_lines 50

set-face global LineFlagHint yellow

define-command lsp-restart -docstring "Restart kak-lsp session" %{ lsp-stop; lsp-start }

define-command lsp-init -docstring "Enable LSP with default setting" %{
  echo -debug "Enabling LSP for filetype %opt{filetype}"
  lsp-enable-window
  lsp-inlay-hints-enable global
  # lsp-inlay-diagnostics-enable global
  lsp-auto-signature-help-enable

  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    rmhooks window semantic-tokens
  }
}

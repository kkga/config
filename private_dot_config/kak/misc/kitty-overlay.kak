hook -group kitty-integration global User 'TERM=xterm-kitty' %{
  define-command kitty-popup -override -params 1.. -shell-completion -docstring 'launch kitty overlay window' %{
    kitty-terminal --type=overlay %arg{@}
  }
  define-command kitty-split -override -params 1.. -shell-completion -docstring 'launch kitty overlay window' %{
    kitty-terminal --type=window --location=hsplit %arg{@}
  }
  alias global terminal-popup kitty-popup
  alias global terminal-panel kitty-split
}

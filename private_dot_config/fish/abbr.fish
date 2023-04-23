# git
abbr g git

# config
abbr cfg "git --work-tree=$HOME/ --git-dir=$HOME/.local/share/yadm/repo.git"

# pnpm
abbr pn pnpm
abbr pnx pnpx

# configs
abbr cm chezmoi

# kakoune
abbr k "kks edit"
abbr ks "eval (kks-select)"
abbr ka "kks attach"
abbr kd "set -e KKS_SESSION KKS_CLIENT"
abbr kkd "kks kill; set -e KKS_SESSION KKS_CLIENT"
abbr kcd "cd (kks get %sh{pwd})"

# notes
abbr notes "zk -W ~/notes e"
abbr notes-retool "zk -W ~/retool-notes e"

# programs
alias ls="exa --color=auto --group-directories-first -h"
alias la="exa -alh"
alias cat="bat"
alias lg="lazygit"

# cp/mv
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -i"

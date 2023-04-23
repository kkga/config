# git
abbr g git

# config
abbr cfg "git --work-tree=$HOME/ --git-dir=$HOME/.local/share/yadm/repo.git"

# pnpm
abbr pn pnpm
abbr pnx pnpx

# void
# abbr vsvu "SVDIR=~/.local/service/ vsv"
# abbr xr "doas xbps-remove -Ro"
# abbr xi "doas xbps-install -S"
# abbr xu "doas xbps-install -Su"

# arch
abbr pacclean "pacman -Qdtq | sudo pacman -Rs -"

# configs
abbr y yadm
abbr yg 'lazygit -w ~ -g ~/.local/share/yadm/repo.git/'

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
# abbr np "zk -W ~/projects/kkga/notes e"

# programs
alias ls="exa --color=auto --group-directories-first -h"
alias la="exa -alh"
alias cat="bat"
# alias t="tdx"
# alias b="browser"
alias lg="lazygit"

# cp/mv
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -i"

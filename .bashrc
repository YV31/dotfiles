#
# ~/.bashrc
#

# If not running interactively, don't do anything

[[ $- != *i* ]] && return

set -o vi

source ~/.config/shell/prompt

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

alias la='ls -lah'
alias ls='ls --color=auto'
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
alias dof="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

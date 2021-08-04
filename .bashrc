#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi mode
set -o vi

#bash prompt
PS1='[\u \W]\$ '

# set terminal emulator
export TERM=xterm-color

###
# aliases
#
alias ls='ls --color=auto'  #enable ls colors
alias tat='tmux attach-session -t'

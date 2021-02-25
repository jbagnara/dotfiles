#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#bash prompt
PS1='[\u \W]\$ '

#set terminal emulator
export TERM=xterm-color

#aliases
alias svim="vim -c \"set tabstop=4 softtabstop=-1 shiftwidth=0 expandtab\"" # vim shane mode
alias ls='ls --color=auto'  #enable ls colors

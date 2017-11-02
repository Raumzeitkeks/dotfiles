alias ..='cd ..'
alias ...='cd ../..'

# ls
LS_OPTS="-l --color=auto"
alias ls="ls $LS_OPTS"
alias la="ls -a"
unset LS_OPTS

# less
LESS_OPTS="-i"
alias less="less $LESS_OPTS"
unset LESS_OPTS

# grep
GREP_OPTS='--color=auto --exclude-dir={.git,.hg,.svn}'
alias grep="grep $GREP_OPTS"
alias egrep="egrep $GREP_OPTS"
alias fgrep="fgrep $GREP_OPTS"
unset GREP_OPTS

# git
alias gi="git status"
alias gg="git gui &"
alias gk="gitk &"

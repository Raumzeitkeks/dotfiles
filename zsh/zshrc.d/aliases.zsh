alias ..='cd ..'
alias ...='cd ../..'

LS_OPTS="-l --color=auto"
alias ls="ls $LS_OPTS"
alias la="ls -a"
unset LS_OPTS

GREP_OPTS='--color=auto --exclude-dir={.git,.hg,.svn}'
alias grep="grep $GREP_OPTS"
alias egrep="egrep $GREP_OPTS"
alias fgrep="fgrep $GREP_OPTS"
unset GREP_OPTS

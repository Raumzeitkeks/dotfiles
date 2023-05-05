# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../../..'

# ls
alias ls="ls --color=auto"
alias ll="ls -ahlF --group-directories-first --color=auto"

# less
alias less="less -i"

# grep
GREP_OPTS='--color=auto --exclude-dir={.git,.hg,.svn}'
alias grep="grep $GREP_OPTS"
alias egrep="egrep $GREP_OPTS"
alias fgrep="fgrep $GREP_OPTS"
unset GREP_OPTS

# git
alias gg="nohup git gui >/dev/null 2>&1 &"
alias gk="nohup gitk --all >/dev/null 2>&1 &"

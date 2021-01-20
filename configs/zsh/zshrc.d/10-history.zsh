# History file location and size
HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=25000

# Disable beep on history miss
unsetopt  HIST_BEEP

# Remove unnecessary blanks in commands
setopt  HIST_REDUCE_BLANKS

# Use the history from multiple instances simultaneously
setopt  SHARE_HISTORY


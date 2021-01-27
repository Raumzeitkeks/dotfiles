# History file location and size
HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=25000
setopt HIST_EXPIRE_DUPS_FIRST

# Disable beep on history miss
unsetopt HIST_BEEP

# Remove unnecessary blanks in commands
setopt HIST_REDUCE_BLANKS

# Ignore consecutive duplicate lines
setopt HIST_IGNORE_DUPS

# Write new lines to histfile immediately
setopt INC_APPEND_HISTORY


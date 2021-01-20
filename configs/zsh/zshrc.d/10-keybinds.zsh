# Use emacs mode
bindkey -e

## Adjust cursor in vim mode
#function zle-line-init zle-keymap-select {
#  case $KEYMAP in
#    vicmd) printf "\e[2 q";; # block cursor
##    vicmd) printf "\e[4 q";; # underscore cursor
#    viins|main) printf "\e[6 q";; # beam cursor
#  esac
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

# Keycodes
# Keycodes taken from terminfo should work for any terminal.
# Modified keycodes from below are tested for termite and kitty.
# Test keycodes for your terminal by typing Ctrl-v followed by the keys in question.
typeset -A key
key=(
	Home        "${terminfo[khome]}"
	AltHome     "^[[1;3H"
	CtrlHome    "^[[1;5H"
	End         "${terminfo[kend]}"
	AltEnd      "^[[1;3F"
	CtrlEnd     "^[[1;5F"
	Insert      "${terminfo[kich1]}"
	Delete      "${terminfo[kdch1]}"
	CtrlBack    "^H"
	Up          "${terminfo[kcuu1]}"
	ShiftUp     "^[[1;2A"
	AltUp       "^[[1;3A"
	CtrlUp      "^[[1;5A"
	Down        "${terminfo[kcud1]}"
	ShiftDown   "^[[1;2B"
	AltDown     "^[[1;3B"
	CtrlDown    "^[[1;5B"
	Right       "${terminfo[kcuf1]}"
	ShiftRight  "^[[1;2C"
	AltRight    "^[[1;3C"
	CtrlRight   "^[[1;5C"
	Left        "${terminfo[kcub1]}"
	ShiftLeft   "^[[1;2D"
	AltLeft     "^[[1;3D"
	CtrlLeft    "^[[1;5D"
	PageUp      "${terminfo[kpp]}"
	AltPgUp     "^[[5;3~"
	CtrlPgUp    "^[[5;5~"
	PgDown      "${terminfo[knp]}"
	AltPgDown   "^[[6;3~"
	CtrlPgDown  "^[[6;5~"
	BackTab     "${terminfo[kcbt]}"
)


# Functions
function _prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}
zle -N _prepend-sudo

function _replace-first-word() {
	zle beginning-of-line
	zle delete-word
}
zle -N _replace-first-word


# Movement
bindkey ${key[Home]}        beginning-of-line
bindkey ${key[End]}         end-of-line
bindkey ${key[Up]}          up-line-or-search
bindkey ${key[Down]}        down-line-or-search
bindkey ${key[CtrlRight]}   forward-word
bindkey ${key[CtrlLeft]}    backward-word

# Modification
bindkey "${key[AltHome]}"   _prepend-sudo
bindkey "${key[CtrlHome]}"  _replace-first-word
bindkey "${key[CtrlBack]}"  backward-kill-word

# Completion
zmodload zsh/complist
bindkey -M menuselect ${key[BackTab]}  reverse-menu-complete

# Search
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^f' history-incremental-pattern-search-forward


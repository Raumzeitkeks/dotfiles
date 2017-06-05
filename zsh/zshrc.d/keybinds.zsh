# Use emacs mode
bindkey -e

# Abbreviations
# Keycodes taken from terminfo should work for any terminal
# Modified keyscodes are tested for TERM=xterm-termite
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
bindkey '^s' history-incremental-pattern-search-forward

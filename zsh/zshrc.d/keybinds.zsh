# Use emacs mode
bindkey -e

# Abbreviations
# Keycodes taken from terminfo should work for any terminal
# Modified keyscodes are tested for TERM=xterm-termite
typeset -A key
key=(
	Home        "${terminfo[khome]}"
	CtrlHome    "^[[1;5H"
	End         "${terminfo[kend]}"
	CtrlEnd     "^[[1;5F"
	Insert      "${terminfo[kich1]}"
	Delete      "${terminfo[kdch1]}"
	CtrlBack    "^H"
	Up          "${terminfo[kcuu1]}"
	ShiftUp     "^[[1;2A"
	CtrlUp      "^[[1;5A"
	Down        "${terminfo[kcud1]}"
	ShiftDown   "^[[1;2B"
	CtrlDown    "^[[1;5B"
	Right       "${terminfo[kcuf1]}"
	ShiftRight  "^[[1;2C"
	CtrlRight   "^[[1;5C"
	Left        "${terminfo[kcub1]}"
	ShiftLeft   "^[[1;2D"
	CtrlLeft    "^[[1;5D"
	PageUp      "${terminfo[kpp]}"
	CtrlPgUp    "^[[5;5~"
	PgDown      "${terminfo[knp]}"
	CtrlPgDown  "^[[6;5~"
	BackTab     "${terminfo[kcbt]}"
)

# Functions
function _after-first-word() {
	zle beginning-of-line
	zle emacs-forward-word
}
zle -N _after-first-word

function _replace-first-word() {
	zle beginning-of-line
	zle delete-word
}
zle -N _replace-first-word


# Movement
bindkey ${key[Home]}        _after-first-word
bindkey ${key[End]}         end-of-line
bindkey ${key[Up]}          up-line-or-search
bindkey ${key[Down]}        down-line-or-search
bindkey ${key[CtrlRight]}   forward-word
bindkey ${key[CtrlLeft]}    backward-word

# Modification
bindkey "${key[CtrlHome]}"  _replace-first-word
bindkey "${key[CtrlBack]}"  backward-kill-word

# Completion
zmodload zsh/complist
bindkey -M menuselect ${key[BackTab]}  reverse-menu-complete

# Search
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# Get the directory where this file is located
_custom_zsh_config_base="${${(%):-%x}:A:h}"

# bail out if global config is disabled
[[ $_custom_zsh_config_base == /etc/* && $_custom_zsh_no_global == 1 ]] && return

# Bail out if we are already loaded
[[ _custom_zsh_config_loaded == 1 ]] && return
_custom_zsh_config_loaded=1

# Create cache folder for compdump etc.
ZSH_CACHE="/tmp/.zsh-${USER}-${ZSH_VERSION}"
mkdir -p $ZSH_CACHE
chmod 700 $ZSH_CACHE

# Make sure the terminal is in application mode, when zle is active.
# (This is expected behavior for line editors. E.g. only then the values from $terminfo are valid.)
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Load all config files
for file ($_custom_zsh_config_base/zshrc.d/*.zsh(N)); do
    source $file
done

# Diable beep
unsetopt  BEEP


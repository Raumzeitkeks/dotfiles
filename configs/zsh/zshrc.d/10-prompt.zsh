# VCS information
autoload -Uz vcs_info
precmd() vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' max-exports 10
zstyle ':vcs_info:git*' get-revision true
zstyle ':vcs_info:git*' check-for-staged-changes true
zstyle ':vcs_info:git*' stagedstr '*'
zstyle ':vcs_info:git*' patch-format '%p [%n|%c]'
zstyle ':vcs_info:git*' formats       '%R' '%r' '%S' '%b' '%i' '%c'
zstyle ':vcs_info:git*' actionformats '%R' '%r' '%S' '%b' '%i' '%c' '%a' '%m'

# Enable command substitution in promps
setopt PROMPT_SUBST

(){
  local err='%B%(?,%F{green}✔%f,%F{red}✘%f)%b '
  local basepath='%F{blue}${${${vcs_info_msg_0_%$vcs_info_msg_1_}/#$HOME/~}:-${${${(%):-%~}#[~]}:+${${(%):-%~}%/*}/}}%f'
  local coolpath='%F{blue}${${vcs_info_msg_0_:+${${${vcs_info_msg_2_#[.]}:+%U$vcs_info_msg_1_%u${${(%):-/$vcs_info_msg_2_}%/*}/%B${vcs_info_msg_2_##*/}%b}:-%U%B$vcs_info_msg_1_%b%u}}:-%B${${(%):-%~}##*/}%b}%f'
  local cwd="$basepath$coolpath "
  local vcs='${vcs_info_msg_0_:+%B[%b%F{magenta\}$vcs_info_msg_3_:${vcs_info_msg_4_:0:7}${vcs_info_msg_5_:+ $vcs_info_msg_5_}${vcs_info_msg_6_:+ ($vcs_info_msg_6_${vcs_info_msg_7_:+ | $vcs_info_msg_7_})}%f%B]%b }'
  local arrow='%B%F{black}%(!.#.>>)%f%b '

  # main prompt
  PROMPT="$err$cwd$vcs$arrow"

  # continuation prompt
  PROMPT2='%B%_${${(%):-%_}:+ }... %b'

  # selection prompt
  PROMPT3='%BChoose:%b '

  # correction prompt
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [yNae]? '
}


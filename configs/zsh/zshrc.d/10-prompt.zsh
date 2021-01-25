# VCS information
autoload -Uz vcs_info
precmd() vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:git*' check-for-staged-changes true
zstyle ':vcs_info:git*' stagedstr '*'
zstyle ':vcs_info:git*' patch-format '%p [%n|%c]'
zstyle ':vcs_info:git*' formats       '%r' '%S' '%b' '%c'
zstyle ':vcs_info:git*' actionformats '%r' '%S' '%b' '%c' '%a' '%m'

# Enable command substitution in promps
setopt PROMPT_SUBST

(){
  local err='%B%(?,%F{green}✔%f,%F{red}✘%f)%b '
  local basepath='%F{blue}${${vcs_info_msg_0_:+${${(%):-%~}%$vcs_info_msg_0_${${vcs_info_msg_1_#[.]}:+/$vcs_info_msg_1_}}}:-${${${(%):-%~}#[~]}:+${${(%):-%~}%/*}/}}%f'
  local coolpath='%F{blue}${${vcs_info_msg_0_:+${${${vcs_info_msg_1_#[.]}:+%U$vcs_info_msg_0_%u${${(%):-/$vcs_info_msg_1_}%/*}/%B${vcs_info_msg_1_##*/}%b}:-%U%B$vcs_info_msg_0_%b%u}}:-%B${${(%):-%~}##*/}%b}%f'
  local cwd="$basepath$coolpath "
  local vcs='${vcs_info_msg_0_:+%B[%b%F{magenta\}$vcs_info_msg_2_${vcs_info_msg_3_:+ $vcs_info_msg_3_}${vcs_info_msg_4_:+ ($vcs_info_msg_4_${vcs_info_msg_5_:+ | $vcs_info_msg_5_})}%f%B]%b }'
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


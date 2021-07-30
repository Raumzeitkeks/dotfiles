zmodload zsh/datetime
autoload -Uz vcs_info

preexec () {
  # capture execution start time
  start_time=${EPOCHREALTIME}
}

precmd () {
  # measure and format execution time
  unset elapsed
  if (( start_time )); then
    local -F elapsed_time_float=$(( EPOCHREALTIME - start_time ))
    local -i elapsed_time_int=${elapsed_time_float}
    local -i h=$(( elapsed_time_int/3600 ))
    local -i m=$(( (elapsed_time_int/60)%60 ))
    local -F s=$(( elapsed_time_float%60 ))
    LC_NUMERIC=C printf -v elapsed '%02d:%02d:%06.3f' $h $m $s
    unset start_time
  fi
  # record vcs information
  vcs_info
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:git*' check-for-staged-changes true
zstyle ':vcs_info:git*' stagedstr '*'
zstyle ':vcs_info:git*' patch-format '%p [%n|%c]'
zstyle ':vcs_info:git*' formats       '%r' '%S' '%b' '%c'
zstyle ':vcs_info:git*' actionformats '%r' '%S' '%b' '%c' '%a' '%m'

# Enable command substitution in promps
setopt PROMPT_SUBST

() {
  local info='%B%(?,%F{green}✔,%F{red}✘)%b${elapsed:+ $elapsed}%f '
  local clock='─── %F{cyan}%*%f ───'
  local newline=$'\n'
  local basepath='%F{blue}${${vcs_info_msg_0_:+${${(%):-%~}%$vcs_info_msg_0_${${vcs_info_msg_1_#[.]}:+/$vcs_info_msg_1_}}}:-${${${(%):-%~}#[~]}:+${${(%):-%~}%/*}/}}%f'
  local coolpath='%F{blue}${${vcs_info_msg_0_:+${${${vcs_info_msg_1_#[.]}:+%U$vcs_info_msg_0_%u${${(%):-/$vcs_info_msg_1_}%/*}/%B${vcs_info_msg_1_##*/}%b}:-%U%B$vcs_info_msg_0_%b%u}}:-%B${${(%):-%~}##*/}%b}%f'
  local cwd="$basepath$coolpath "
  local vcs='${vcs_info_msg_0_:+%B[%b%F{magenta\}$vcs_info_msg_2_${vcs_info_msg_3_:+ $vcs_info_msg_3_}${vcs_info_msg_4_:+ ($vcs_info_msg_4_${vcs_info_msg_5_:+ | $vcs_info_msg_5_})}%f%B]%b }'
  local arrow='%B%F{black}%(!.#.>>)%f%b '

  # main prompt
  PROMPT="$info$clock$newline$cwd$vcs$arrow"

  # continuation prompt
  PROMPT2='%B%_${${(%):-%_}:+ }... %b'

  # selection prompt
  PROMPT3='%BChoose:%b '

  # correction prompt
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [yNae]? '
}


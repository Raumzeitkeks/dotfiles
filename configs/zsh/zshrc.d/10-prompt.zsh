zmodload zsh/datetime

preexec () {
  # capture execution start time
  start_time=${EPOCHREALTIME}
}

precmd () {
  # measure and format execution time
  unset elapsed
  elapsed="00:00:00.000"
  if (( start_time )); then
    local -F elapsed_time_float=$(( EPOCHREALTIME - start_time ))
    local -i elapsed_time_int=${elapsed_time_float}
    local -i h=$(( elapsed_time_int/3600 ))
    local -i m=$(( (elapsed_time_int/60)%60 ))
    local -F s=$(( elapsed_time_float%60 ))
    LC_NUMERIC=C printf -v elapsed '%02d:%02d:%06.3f' $h $m $s
    unset start_time
  fi
}

# Enable command substitution in promps
setopt PROMPT_SUBST

() {
  local rc='%(?,%F{green}[---],%F{red}[${(l:3::0:)${(%):-%?}}])%f '
  local time='%B%F{yellow}$elapsed%f%b '
  local cwd='%F{blue}%~%f '
  local git='$(__git_ps1 "[%s] ")'
  local arrow='%B%F{black}%(!.#.>>)%f%b '

  # main prompt
  PROMPT="$rc$time$cwd$git$arrow"

  # continuation prompt
  PROMPT2='%B%_${${(%):-%_}:+ }... %b'

  # selection prompt
  PROMPT3='%BChoose:%b '

  # correction prompt
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [yNae]? '
}

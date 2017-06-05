# VCS information
autoload -Uz vcs_info
precmd() vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' nvcsformats ''
zstyle ':vcs_info:git*' check-for-changes false
zstyle ':vcs_info:git*' check-for-staged-changes false
zstyle ':vcs_info:git*' get-revision false
zstyle ':vcs_info:git*' formats '%b'

# Enable command substitution in promps
setopt  PROMPT_SUBST

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Correction prompt
SPROMPT='zsh: correct '%F{166}%R%f' to '%F{76}%r%f' [nyae]? '

# PS1 through PS3 prompt
(){
  local left right nextline invisible leftcontent rightcontent spacer continuation selection

  # error indicator
  left+='%B%(?,%F{cyan}.,%F{red}!)%b%f'
  # deco
  left+='%F{cyan}-%f'
  # path
  left+='%B%F{black}(%B%F{green}%~%B%F{black})%b%f'
  # deco
  left+='%F{cyan}--%f'
  # git branch
  left+='%B%F{black}${vcs_info_msg_0_:+[}%F{magenta}${vcs_info_msg_0_}%F{black}${vcs_info_msg_0_:+]}%b%f'

  # time
  right+='%B%F{black}[%F{cyan}%b%n%B@%b%m%B%F{black}]%b%f'
  # deco
  right+='%F{cyan}--%f'
  # user@host
  right+='%B%F{black}(%F{cyan}%T%F{black})%b%f'
  # deco
  right+='%F{cyan}-%f'

  # deco
  nextline+='%B%F{cyan}\`%b--%f'
  # arrow
  nextline+='%B%F{white}%(!.#.>)%b%f'
  # end
  nextline+=' %b%f%k'

  # create spacer
  invisible='%([BSUbfksu]|([FBK]|){*})'
  leftcontent="${(S)left//$~invisible}"
  rightcontent="${(S)right//$~invisible}"
  spacer="%F{cyan}\${(l<COLUMNS-\${#\${(%):-$leftcontent$rightcontent}}><->)}%f"

  PS1="$left$spacer$right$nextline"


  # continuation indicatior
  continuation+='%B%F{white}%_%b%f'
  # deco
  continuation+=" "
  # arrow
  continuation+='%B%F{white}%(!.#.>)%b%f'
  # end
  continuation+=" %b%f%k"
  PS2="$continuation"


  # text
  selection+='%B%F{white}Choose:%b%f'
  # end
  selection+=" %b%f%k"
  PS3="$selection"
}

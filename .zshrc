# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ensure your shell’s LANG or LC_ALL is UTF-8
export LANG=en_US.UTF-8


# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# theme
## Copy this into your .zshrc file
export COLOR_RESET=$'\x1b[0m'
export COLOR_LACK=$'\x1b[38;2;112;128;144m'
export COLOR_LUSTER=$'\x1b[38;2;222;238;237m'
export COLOR_ORANGE=$'\x1b[38;2;255;170;136m'
export COLOR_GREEN=$'\x1b[38;2;120;153;120m'
export COLOR_BLUE=$'\x1b[38;2;119;136;170m'
export COLOR_RED=$'\x1b[38;2;215;0;0m'
export COLOR_BLACK=$'\x1b[38;2;0;0;0m'
export COLOR_GRAY1=$'\x1b[38;2;8;8;8m'
export COLOR_GRAY2=$'\x1b[38;2;25;25;25m'
export COLOR_GRAY3=$'\x1b[38;2;42;42;42m'
export COLOR_GRAY4=$'\x1b[38;2;68;68;68m'
export COLOR_GRAY5=$'\x1b[38;2;85;85;85m'
export COLOR_GRAY6=$'\x1b[38;2;122;122;122m'
export COLOR_GRAY7=$'\x1b[38;2;170;170;170m'
export COLOR_GRAY8=$'\x1b[38;2;204;204;204m'
export COLOR_GRAY9=$'\x1b[38;2;221;221;221m'

# You can use these colors in your scripts...
# echo "${COLOR_BLUE}Some message${COLOR_RESET}"

# date=$(date '+%Y-%m-%d')
# timeVar=$(date '+%X')
# # You can use these colors in your scripts...
# echo "${COLOR_GRAY6}$date | $timeVar | battery: $(cat /sys/class/power_supply/BAT*/capacity)%${COLOR_RESET}"
# echo "${COLOR_GRAY6}${COLOR_RESET}"

#---- PROMPT ---- ##############################################
lackluster_reset_prompt(){
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      LL_BRANCH_NAME='(detached)'
     else 
      LL_BRANCH_NAME="[$branch]"
    fi
  else 
    LL_BRANCH_NAME=''
  fi

  git_status_result=$(git status --porcelain 2> /dev/null)
  if [[ "$git_status_result" != "" ]]; then
     # branch is dirty
     LL_BRANCH_COLOR=$COLOR_ORANGE
  else
     # branch is clean
     LL_BRANCH_COLOR=$COLOR_GRAY6
  fi

  LL_PWD=${PWD/$HOME/}
  if [[ $LL_PWD = "" ]];then
      LL_PWD="~"
  fi

  LL_PROMPT=$'\n'"| "
  return 0
}

setopt prompt_subst
autoload -U add-zsh-hook 
add-zsh-hook precmd lackluster_reset_prompt
PROMPT='%{$LL_BRANCH_COLOR%}${LL_BRANCH_NAME} %{$COLOR_GRAY5%}${LL_PWD}%{$COLOR_RESET%}${LL_PROMPT}'

# UNCOMMENT THIS IF YOU USE VI MODE
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/N}/(main|viins)/ I}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# vi mode
set -o vi
bindkey -v

# setup zoxide
eval "$(zoxide init zsh)"

export EDITOR=nvim
export VISUAL=nvim

# alias
export PATH="$HOME/.cargo/bin:$PATH"

# sleep and lock
alias lockme='gtklock & systemctl sleep'

# search for directorys from the root directory
alias sac='z $(find / -type d -print | fzf)'

# search for directorys in the current directory
alias fid='z $(find -type d -print | fzf)'

# see the battery percentage
alias battery='echo "${COLOR_GRAY6}Battery: $(cat /sys/class/power_supply/BAT*/capacity)%${COLOR_RESET}"'

# copy the current path
alias cdpwd='pwd | wl-copy'

# make for cs50
alias make50='make CC=clang CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wshadow" LDLIBS="-lcrypt -lcs50 -lm"'

# Created by `pipx` on 2024-10-27 05:23:26
export PATH="$PATH:/home/thispc/.local/bin"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#dddddd,bg:-1,bg+:#333333
  --color=hl:#708090,hl+:#708090,info:#555555,marker:#789978
  --color=prompt:#708090,spinner:#708090,pointer:#708090,header:#708090
  --color=border:#242424,label:#aeaeae,query:#d9d9d9'

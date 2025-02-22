#!/bin/zsh
#
# vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d : -f 2)
# datime=$(date +'%Y-%m-%d %X')
# lang=$(swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .xkb_active_layout_name')
#
# while :
#   echo "${COLOR_GRAY6}$(swaymsg -t get_inputs | jq -r '[.[] | select(.type=="keyboard") | .xkb_active_layout_name][0]') | battery: $(cat /sys/class/power_supply/BAT*/capacity)% | $(date '+%X') | $(date '+%Y-%m-%d')${COLOR_RESET}"
# do sleep 1;
# done;
#
while :
do
  lang=$(swaymsg -t get_inputs | jq -r '[.[] | select(.type=="keyboard") | .xkb_active_layout_name][0]')

  case "$lang" in
    *English*) lang="en" ;;
    *Arabic*) lang="ar" ;;
    *) lang="??" ;;  # Fallback for other layouts
  esac

  echo "${COLOR_GRAY6}${lang} | battery: $(cat /sys/class/power_supply/BAT*/capacity)% | $(date '+%X') | $(date '+%Y-%m-%d')${COLOR_RESET}"
  sleep 0.5
done


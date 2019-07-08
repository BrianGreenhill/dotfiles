#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -z "$TMUX" ]; then
  /home/brian/bin/sshadd
fi
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx &> /dev/null
fi

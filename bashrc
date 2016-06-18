#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Git-prompt
source ~/.git-prompt.sh

# Reset
Color_Off='\e[0m'       # Text Reset

# # Regular Colors
BLACK='\e[0;30m'        # Black
RED='\e[0;31m'          # Red
GREEN='\e[0;32m'        # Green
YELLOW='\e[0;33m'       # Yellow
BLUE='\e[0;34m'         # Blue
PURPLE='\e[0;35m'       # Purple
CYAN='\e[0;36m'         # Cyan
WHITE='\e[0;37m'        # White

PS1="\[$BLUE\]\w\[$PURPLE\]\$(__git_ps1)\[$Color_Off\]\$ "

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

## functions ## {{{

# Simple calculator
calc () {
    echo "scale=3;$@" | bc -l
}

note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch $HOME/.notes
    fi

    if [[ $# -eq 0 ]]; then
        # no arguments, print file
        cat $HOME/.notes
    elif [[ "$1" == "-c" ]]; then
        # clear file
        echo "" > $HOME/.notes
    else
        # add all arguments to file
        echo "$@" >> $HOME/.notes
    fi
}

videoCut () {
    if [[ $# -le 3 ]]; then
        echo "videoCut <input> <from> <to> <output>"
    else 
        # https://www.virag.si/2012/01/webm-web-video-encoding-tutorial-with-ffmpeg-0-9/
        ffmpeg -i $1 -codec:v libvpx -quality good -cpu-used 0 -b:v 500k -qmin 10 -qmax 42 -maxrate 500k -bufsize 1000k -threads 4 -vf scale=-1:480 -codec:a libvorbis -b:a 128k -ss $2 -to $3 $4
    fi

}

convert2webm () {
    if [[ $# -le 1 ]]; then
        echo "videoCut <input> <output>.webm"
    else 
        # https://www.virag.si/2012/01/webm-web-video-encoding-tutorial-with-ffmpeg-0-9/
        ffmpeg -i $1 -codec:v libvpx -quality good -cpu-used 0 -b:v 500k -qmin 10 -qmax 42 -maxrate 500k -bufsize 1000k -threads 4 -vf scale=-1:480 -codec:a libvorbis -b:a 128k $2
    fi

}

anacondactl() {
    case $1 in
        start) echo "$PATH" | grep -q "/opt/anaconda/bin:" || export PATH="/opt/anaconda/bin:":$PATH ;;
        stop)  echo "$PATH" | grep -q "/opt/anaconda/bin:" && export PATH=${PATH/"\/opt\/anaconda\/bin:"/} ;;
        status) if [ $(echo $PATH | grep anaconda | wc -l) -gt 0 ] ; then echo "Anaconda python" ; else echo "Native python" ; fi ;;
        *) echo "Usage: anacondactl [start,stop,status]" ;;
    esac
}
# }}}

# Make Caps an additional Control key
#setxkbmap -option caps:ctrl_modifier
#setxkbmap -layout us,ara -option grp:win_space_toggle

# Touchpad
synclient PalmDetect=1
synclient PalmMinWidth=6
synclient PalmMinZ=60
synclient HorizTwoFingerScroll=1
synclient VertEdgeScroll=1


# Keyboard speed and delay
xset r rate 200 30

PROMPT_DIRTRIM=3

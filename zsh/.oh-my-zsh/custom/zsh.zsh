## This file is public on github
# ZSH config is in ~/.zshrc
export EDITOR=vim
ZSH_THEME="agnoster"
#RPROMPT="%j %{$fg[red]%}$(ruby --version | awk '{print $2}')%{$reset_color%}%"
#RPROMPT="%j"

#LC_CTYPE=en_US.UTF-8
#LC_ALL=en_US.UTF-8

#stty stop undef
#xset r rate 255

############ SSH tips
# Access a servers website (behind a firewall) on ip:8080
# Server needs to add 'GatewayPorts yes' in /etc/ssh/sshd_config
# ssh -L 8080:localhost:80 user@host

# Allow Local device to access the tunnel via lanip:8080
# ssh -L \*8080:localhost:8443 user@host

# display my local rails app(must be running on 3000) on a remote machine:8080
# ssh -R 8080:localhost:3000 user@remote

# If hopserver:2200 is the only one with ssh access to endpoint:2200
# ssh -p2200 root@hopserver -L 2201:endpoint:2200 -N
# Then ftp to localhost port 2201

# ssh -D 12345 root@proxyserver
# Firefox: Pref - Advanced - Network - Settings -Manual Proxy
# - Socks Host: localhost, Port 12345
# ssh -D 192.168.0.10 ... allows lan clients to share the tunnel (not only localhost)

#programs
alias handy="printf 'Keyboard: \txmodmap -pke, xev, showkey,
Programs: \tgetprocid, exo-preferred-applications,
Volume: \tpavucontrol, paprefs (RTP settings for network server)
Color picker: \tgpick
Touchpad: \txinput
dd progress: \tsudo kill -USR1 $(pgrep ^dd)
debug: \t dmesg, vmstat 1, mpstat -P ALL, iostat -xz 1,
debug: \t sar -n DEV 1, sar -n TCP, ETCP 1
webcamgrab: outputs to /tmp
'"

alias edit='vi ~/.oh-my-zsh/custom/zsh.zsh'       # (edit this file)
alias zshrc='vi ~/.zshrc'

# Programs etc
alias ap='ansible-playbook'
alias aps='apt search'
alias acs='apt-cache search'
alias acp='apt-cache policy'
alias agi='sudo apt-get install'
alias ai='sudo apt install -y'
alias au='sudo apt update -y'
alias auu='sudo apt update -y && sudo apt upgrade -y'
alias b='bundle'
alias be='bundle exec'
alias bu='bundle update'
alias cast='python3 ~/dev/mkchromecast/bin/mkchromecast'
alias castn='python3 ~/dev/mkchromecast/bin/mkchromecast -n Tonlyst'
alias castt='python3 ~/dev/mkchromecast/bin/mkchromecast -t'
alias doci='docker images'
alias doco='docker compose'
alias docrmc='docker rm `docker ps -aq`'
alias docrmi='docker rmi --force'
alias docrmu='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias dst='docker stats $(docker ps --format={{.Names}})'
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias fm='free -m'
alias gap='git add -p'
alias getprocid='xprop | grep WM_CLASS'
alias gop="open \`git remote -v | grep 'git@github.com\|git@gitlab.' | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'\`"
alias hgrep='history|grep'
alias htop='htop -d 30'
#alias img=gpicview
alias img=feh
alias open=xdg-open
alias pi='ping 8.8.8.8'
alias r='./bin/rails'
alias rs='./bin/rails server -b 0.0.0.0'
alias rc='./bin/rails console'
alias rv='ruby --version'
alias rgrep='rgrep --color'
alias sshc='vi ~/.ssh/config'
alias vpiano='fluidsynth -a alsa -s -g 3 /usr/share/sounds/sf2/FluidR3_GM.sf2'
alias vmidi='aconnect 20:0 128:0'
alias v='n'
alias vi='n'
alias vim='vim -p'
alias vimrc='vim ~/.vimrc'
alias n='nvim -p'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias webcamgrab="ffmpeg -f video4linux2 -i /dev/video0 -vframes 1 -strftime 1 /tmp/%Y-%m-%d_%H-%M-%S_webcamgrab.jpg"
alias xclip='xclip -selection c'
alias sconfig='vi ~/dotfiles/sway/.sway/config'

# Folders
alias y="cd ~/dev/youwind/"
alias re="cd ~/dev/repero/"
alias l=la
alias la='ls -lAhp --group-directories-first'
alias ll='ls -lahp --group-directories-first'
alias lt='ll -atr'

# Switch timezones
alias CAN="timedatectl set-timezone Atlantic/Canary"
alias IS="timedatectl  set-timezone Atlantic/Reykjavik"
alias BCN="timedatectl set-timezone Europe/Madrid"

# Scripts
wer() {
  curl wttr.in/${1:-Torrevieja}
}

cheat() {
  curl cheat.sh/$1
}

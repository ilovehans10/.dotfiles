# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#This is only run when the shell originally starts zsh and doesn't run on source ~/.zshrc
#https://superuser.com/questions/1153153/zsh-differentiate-between-source-zshrc-and-shell-initially-reading-zshrc
[ $ZSH_EVAL_CONTEXT = file ] && FRESHSHELL=true
[ "$FRESHSHELL" = true ] && sed -e 's/^#.*$//' -e '/^$/d' ${HOME}/.config/zsh/tips | shuf -n1

# setup vi keybindings
set -o vi

# oh-my-zsh/zplug setup
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 10

# set OS variable for different configurations on different computers
local OS=$(uname -s)

case $OS in
  Darwin)
    export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:/usr/local/Cellar/ruby/2.7.0/bin:/usr/local/lib/ruby/gems/2.7.0/gems:$HOME/Documents/RubyMine/bin:$HOME/go/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:~/Library/Python/3.9/bin:$PATH"
    export FPATH="/Users/larssonh/.local/share/rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions:$FPATH"
    export ZSH="${HOME}/.config/zsh/oh-my-zsh"
    export ZPLUG_HOME="/opt/homebrew/opt/zplug"
    source "${HOME}/.config/.iterm2_shell_integration.zsh";;
  Linux)
    export PATH="/usr/local/lib/ruby/gems/2.6.0/gems:$HOME/Documents/RubyMine/bin:$HOME/go/bin:$HOME/.local/bin:$HOME/.scripts:$HOME/.scripts/i3cmds:$PATH"
    export ZPLUG_HOME="$HOME/.config/zplug"
    export ZSH="${HOME}/.config/oh-my-zsh";;
esac

source $ZPLUG_HOME/init.zsh

# oh-my-zsh configuration
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

# aliases
alias youtube-dl="yt-dlp"
alias yt="yt-dlp"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias lg="lazygit"
alias lsd="du -hd1"
case $OS in
  Darwin)
    alias ls="ls -G";;
  Linux)
    alias ls="ls --color=always -h --group-directories-first";;
esac
alias df="df -h"
alias lsds="du -hd1 | sort -h"
alias mkdir="mkdir -pv"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"
alias vimtip="nvim ~/.config/zsh/tips"
alias zsource="source ~/.zshrc"
alias polybarconfig="nvim ~/.config/polybar/config"
alias i3config="nvim ~/.config/i3/config"
alias sss="sudo systemctl suspend"
alias rsync="noglob rsync --exclude-from=$HOME/.config/git/gitignore"
alias mvr="rsync -Ph"
alias sudo="sudo "

alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias recentminecraft="grep \"lastLaunchTime\" .local/share/multimc/instances/*/instance.cfg | sed -En \"s/^.*instances\/(.*)\/instance.*lastLaunchTime=(.*)/\2 \1/p\" | sort -r | head -n 1 | sed -En \"s/[0-9]* //p\" | xargs multimc --launch && disown"
alias fixsound="pacmd unload-module module-udev-detect && pacmd load-module module-udev-detect"
alias ncmpcpp="(cp -r $HOME/.mpd/playlists $HOME/.cache/mpvbackup/ && echo \"Playlist backup done\") & ncmpcpp"
alias pause="playerctl pause"
alias play="playerctl play"
#alias autobedtime="xrandr --output HDMI-0 --off && (echo -n \$((( \$(date +%s -d '23:45') - \$( date +%s ))/60 )) && echo -n 'm') | xargs sleep && playerctl pause ; sudo systemctl suspend ; sleep 15 ; sleep 3 ; xrandr --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-0 --off --output DP-1 --off --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off ; sleep 5 ; ~/.config/polybar/launch.sh & disown"
alias fixmonitor="xrandr --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal ; ~/.config/polybar/launch.sh & disown"
alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

batteryhealth(){
  tail -n"${@:-1}" ~/.cache/battery
}
yey(){
  yes | yay "$@"
}
yew(){
  yes | yay -Syuw
}
yeys(){
  yes | yay "$@" && sss
}
ses(){
  sudo systemctl enable "$@" ; sudo systemctl start "$@"
}
sds(){
  sudo systemctl disable "$@" ; sudo systemctl stop "$@"
}
ra(){
  ranger "$1" --choosedir=/tmp/.rangerdir; LASTDIR=`cat /tmp/.rangerdir`; cd "$LASTDIR"
}
addtip(){
  echo "$@" >> ${HOME}/.config/zsh/tips
}
tip(){
  sed -e 's/#.*$//' -e '/^$/d' ${HOME}/.config/zsh/tips | shuf -n${1:-1}
}
getline(){
  head -n "$1" "$2" | tail -n 1
}
findw(){
  find . | grep "$1" 2>/dev/null
}
findl(){
  find . | grep "$1" 2>/dev/null | less
}
bedtime(){
    xrandr --output HDMI-0 --off && sleep "$1" && playerctl pause ; sudo systemctl suspend ; sleep 3 ; sleep 3 ; xrandr --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-0 --off --output DP-1 --off --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off ; sleep 3
}
mpvbedtime(){
    xrandr --output HDMI-0 --off && watch -g pgrep "$1" && playerctl pause ; sudo systemctl suspend ; sleep 3 ; fixmonitor
}
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time -p $shell -i -c exit; done
}

# plugins
plugins=(
  archlinux
  copyfile
  copypath
  git
  history-substring-search
  hitchhiker
  rsync
  sudo
  taskwarrior
  themes
  vi-mode
  zsh-autosuggestions
)

zplug romkatv/powerlevel10k, as:theme, depth:1

# source oh-my-zsh/zplug/bindings
source $ZSH/oh-my-zsh.sh

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3

zplug load

source ~/.config/zsh/bindings

unset FRESHSHELL

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

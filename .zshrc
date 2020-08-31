#Set default language to english
export LANG=en_US.UTF-8

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Minimal Prompt
#precmd() { print "" }
#PS1="⟩"
#RPS1="%{$fg[magenta]%}%20<...<%~%<<%{$reset_color%}"

#For TMUX without OhMyZsh TMUX-Plugin
#Enabling Color Prompts
#export TERM="screen-256color"
export TERM="xterm-256color"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

#Autostart Tmux or attach if already running
#if [ "$TMUX" = "" ]
#then
#	tmux list-sessions
#	if [ $? = 0 ]
#	then
#		tmux att -t 0
#	else
#		tmux
#	fi
#fi

#Auto CD
setopt auto_cd

#Spellcheck / Typo Correction
setopt correctall
alias git status='nocorrect git status'

# ANTIGEN - Plugins to Enhance Functionality
#Package Manager
if [[ ! -f ~/antigen.zsh ]]; then
	curl -L git.io/antigen > ~/antigen.zsh
fi

if ! type "starship" > /dev/null; then
  curl -fsSL https://starship.rs/install.sh | bash
fi

source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# VI-Mode
bindkey -v
antigen bundle vi-mode

# Bundles from the default repo (robbyrussell's oh-my-zsh).
#antigen bundle git
#antigen bundle git-flow
antigen bundle copydir antigen bundle colorize
antigen bundle command-not-found
antigen bundle colored-man-pages
antigen bundle web-search
antigen bundle rand-quote
antigen bundle zsh_reload
antigen bundle z
antigen bundle sudo

# TMUX
antigen bundle tmux
ZSH_TMUX_AUTOSTART=false
#ZSH_TMUX_ITERM2=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
#antigen bundle tmuxinator

# Autocomplete
antigen bundle zsh-users/zsh-autosuggestions

# Extra zsh completions
antigen bundle zsh-users/zsh-completions

# CD completion
antigen bundle Vifon/deer
autoload -U deer
zle -N deer
bindkey '\ek' deer # Strg + K

# History
antigen bundle zdharma/history-search-multi-word # Strg + R
#antigen bundle zsh-users/zsh-history-substring-search

# Syntax highlighting bundle.
#antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma/fast-syntax-highlighting
#antigen bundle trapd00r/LS_COLORS
antigen bundle denysdovhan/spaceship-prompt

# Load the Starship Theme:
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Tell Antigen that you're done.
antigen apply

export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

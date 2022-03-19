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

setopt promptsubst

#Spellcheck / Typo Correction
setopt correctall
alias git status='nocorrect git status'

PS1="READY > "

# ZINIT - Plugins to Enhance Functionality
#Package Manager
if [[ ! -a ~/.zinit/bin/zinit.zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/master/doc/install.sh)"
fi

#Replace ls with exa
if type "exa" > /dev/null; then
  alias ls="exa"
fi

source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# VI-Mode
bindkey -v

if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)"
else
  zinit load agkozak/zsh-z
fi

#Coloring
zinit ice wait"2" silent as"command" from"gh-r"
zinit light alecthomas/chroma
ZSH_COLORIZE_TOOL=chroma
#ZSH_COLORIZE_STYLE="colorful"
#ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  OMZP::git \
  OMZP::copypath \
  OMZP::copyfile \
  OMZP::colorize \
  OMZP::command-not-found \
  OMZP::colored-man-pages \
  OMZP::web-search \
  OMZP::sudo \
  OMZP::fzf

#Additional  needed Sources:
#https://github.com/Homebrew/homebrew-command-not-found

# CD completion
zinit ice pick"deer" nocompile
zinit load Vifon/deer
autoload -U deer
zle -N deer
bindkey '^k' deer # Strg + K

# History
zinit light zdharma-continuum/history-search-multi-word # Strg + R
#zinit light zsh-users/zsh-history-substring-search

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit ice wait silent as"program" nocompile run-atpull \
  atinit'ln -s -f "$(pwd)/.tmux.conf" ~/.tmux.conf; cp -n .tmux.conf.local ~/.tmux.conf.local'
zinit light gpakosz/.tmux

# Init Starship Prompt
# Load the Starship Theme:
zinit ice wait silent as"program" id-as'starship' nocompile run-atpull \
  atclone"curl -fsSL https://starship.rs/install.sh | sh" \
  atpull"curl -fsSL https://starship.rs/install.sh | sh" \
  atinit"export STARSHIP_CONFIG=~/.config/starship.toml; eval '$(starship init zsh)'"
zinit light zdharma-continuum/null

#LF Icon Mod
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

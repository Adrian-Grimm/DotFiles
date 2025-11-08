#Required dependencies: curl git fzf

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
export COLORTERM=truecolor

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
if [[ ! -a $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

#Replace ls with eza
if type "eza" > /dev/null; then
  alias ls="eza"
fi

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

# Shell Browser
# UI Library ZUI required for zbrowse
zinit load zdharma-continuum/zui
zinit load zdharma-continuum/zbrowse

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
  atinit'export STARSHIP_CONFIG=~/.config/starship.toml; eval "$(starship init zsh)"'
zinit light zdharma-continuum/null

# Init NVM - Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# CodeEditApp integration
[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"
# Broot integration
source ~/.config/broot/launcher/bash/br

source /Users/adrian/.config/broot/launcher/bash/br

#Set default language to english
export LANG=en_US.UTF-8

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

#THEME-SECTION
#PowerLevel Theme Settings
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
#PL-Promt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon vi_mode context dir_writable dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ssh root_indicator background_jobs command_execution_time virtualenv rbenv rvm time)
#ram
# Double-Lined Prompt
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{014}╭%F{cyan}"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
# VI Mode
POWERLEVEL9K_VI_INSERT_MODE_STRING='INS'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='CMD'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='green'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='blue'
# Status
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
# Time
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M:%S \uf073 %d.%m.%y}"
POWERLEVEL9K_TIME_BACKGROUND='blue'
# Context
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='green'
POWERLEVEL9K_CONTEXT_TEMPLATE="%F{cyan}%n%f"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'
# OS segment
POWERLEVEL9K_OS_ICON_BACKGROUND="blue"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"
# Dirs
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# ANTIGEN - Plugins to Enhance Functionality
#Package Manager
if [[ ! -f ~/antigen.zsh ]]; then
	curl -L git.io/antigen > ~/antigen.zsh
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
antigen bundle copydir
antigen bundle colorize
antigen bundle command-not-found
antigen bundle colored-man-pages
antigen bundle web-search
antigen bundle rand-quote
antigen bundle zsh_reload

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

# Load the theme.
#antigen theme bhilburn/powerlevel9k powerlevel9k
#speed-up Version:
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

# Workaround for https://github.com/zdharma/fast-syntax-highlighting/issues/146
FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"

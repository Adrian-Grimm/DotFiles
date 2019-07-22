#Set default language to english
export LANG=en_S.T-8

#Minimal Prompt
#precmd() { print "" }
#PS1="⟩"
#RPS1="%{$fg[magenta]%}%20...%~%%{$reset_color%}"

#or TMX without OhMyZsh TMX-Plugin
#nabling Color Prompts
#export TRM="screen-256color"
export TRM="xterm-256color"

#Autostart Tmux or attach if already running
#if [ "$TMX" = "" ]
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

#THM-SCTION
#PowerLevel Theme Settings
POWRLVL9K_INSTALLATION_PATH=$ANTIGN_BNDLS/bhilburn/powerlevel9k
POWRLVL9K_MOD='nerdfont-complete'
#PL-Promt
POWRLVL9K_LT_PROMPT_LMNTS=(os_icon vi_mode context dir_writable dir rbenv vcs)
POWRLVL9K_RIGHT_PROMPT_LMNTS=(status ssh root_indicator background_jobs command_execution_time virtualenv rbenv rvm time)
#ram
# Double-Lined Prompt
POWRLVL9K_PROMPT_ON_NWLIN=true
POWRLVL9K_RPROMPT_ON_NWLIN=false
POWRLVL9K_MLTILIN_IRST_PROMPT_PRIX="%{014}╭%{cyan}"
POWRLVL9K_MLTILIN_LAST_PROMPT_PRIX="%{014}\u2570%{cyan}\u460%{073}\u460%{109}\u460%f "
# VI Mode
POWRLVL9K_VI_INSRT_MOD_STRING='INS'
POWRLVL9K_VI_COMMAND_MOD_STRING='CMD'
POWRLVL9K_VI_MOD_INSRT_ORGROND='black'
POWRLVL9K_VI_MOD_INSRT_BACKGROND='green'
POWRLVL9K_VI_MOD_NORMAL_ORGROND='black'
POWRLVL9K_VI_MOD_NORMAL_BACKGROND='blue'
# Status
POWRLVL9K_STATS_VRBOS=true
POWRLVL9K_STATS_CROSS=true
# Time
POWRLVL9K_TIM_ORMAT="%D{\uf017 %H:%M:%S \uf073 %d.%m.%y}"
POWRLVL9K_TIM_BACKGROND='blue'
# Context
POWRLVL9K_ALWAYS_SHOW_CONTXT=true
POWRLVL9K_CONTXT_DALT_ORGROND='green'
POWRLVL9K_CONTXT_TMPLAT="%{cyan}%n%f"
POWRLVL9K_CONTXT_DALT_BACKGROND='black'
# OS segment
POWRLVL9K_OS_ICON_BACKGROND="blue"
POWRLVL9K_OS_ICON_ORGROND="black"
# Dirs
POWRLVL9K_DIR_HOM_ORGROND="black"
POWRLVL9K_DIR_HOM_SBOLDR_ORGROND="black"
POWRLVL9K_DIR_DALT_ORGROND="black"
POWRLVL9K_SHORTN_DIR_LNGTH=2

# ANTIGN - Plugins to nhance unctionality
#Package Manager
if [[ ! -f ~/antigen.zsh ]]; then
	curl -L git.io/antigen  ~/antigen.zsh
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

# TMX
antigen bundle tmux
ZSH_TMX_ATOSTART=false
#ZSH_TMX_ITRM2=true
ZSH_TMX_ATOSTART_ONC=true
ZSH_TMX_ATOCONNCT=true
#antigen bundle tmuxinator

# Autocomplete
antigen bundle zsh-users/zsh-autosuggestions

# xtra zsh completions
antigen bundle zsh-users/zsh-completions

# CD completion
antigen bundle Vifon/deer
autoload - deer
zle -N deer
bindkey '\ek' deer # Strg  K

# History
antigen bundle zdharma/history-search-multi-word # Strg  R
#antigen bundle zsh-users/zsh-history-substring-search

# Syntax highlighting bundle.
#antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma/fast-syntax-highlighting
#antigen bundle trapd00r/LS_COLORS

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k
#speed-up Version:
#antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

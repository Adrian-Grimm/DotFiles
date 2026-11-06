# Required dependencies: curl git fzf (see ~/.config/yadm/bootstrap)

export LANG=en_US.UTF-8

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ---- PATH / Homebrew ------------------------------------------------------
typeset -U path PATH
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x $brew_bin ]] && { eval "$($brew_bin shellenv)"; break; }
done
path=("$HOME/.local/bin" $path)

# ---- Environment ----------------------------------------------------------
# TERM is intentionally not forced; the terminal / tmux set the right value.
export COLORTERM=truecolor
export EDITOR=nvim
export VISUAL=nvim

# ---- History --------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history share_history hist_ignore_dups hist_ignore_space hist_reduce_blanks

# ---- Options --------------------------------------------------------------
setopt auto_cd
setopt promptsubst
setopt correct
alias git='nocorrect git'
bindkey -v   # VI-Mode

# ---- Zinit (plugin manager) -----------------------------------------------
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
  print -P "%F{220}Installing zinit…%f"
  command mkdir -p "${ZINIT_HOME:h}" && command chmod g-rwX "${ZINIT_HOME:h}"
  command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" ||
    print -P "%F{160}zinit clone failed.%f"
fi

if [[ -f $ZINIT_HOME/zinit.zsh ]]; then
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Annexes (without Turbo)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# z / zoxide fallback
if ! (( $+commands[zoxide] )); then
  zinit load agkozak/zsh-z
fi

# Syntax colouring for the colorize plugin
zinit ice wait"2" silent as"command" from"gh-r"
zinit light alecthomas/chroma
ZSH_COLORIZE_TOOL=chroma

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

# CD completion
zinit ice pick"deer" nocompile
zinit load Vifon/deer
autoload -U deer
zle -N deer
bindkey '^k' deer # Ctrl + K

# Shell browser (UI library ZUI required for zbrowse)
zinit load zdharma-continuum/zui
zinit load zdharma-continuum/zbrowse

# History search
zinit light zdharma-continuum/history-search-multi-word # Ctrl + R

# Init Starship Prompt
# Load the Starship Theme:
zinit ice wait silent as"program" id-as'starship' nocompile run-atpull \
  atclone"curl -fsSL https://starship.rs/install.sh | sh" \
  atpull"curl -fsSL https://starship.rs/install.sh | sh" \
  atinit'export STARSHIP_CONFIG=~/.config/starship.toml; eval "$(starship init zsh)"'
zinit light zdharma-continuum/null

# LS_COLORS (macOS: gdircolors from coreutils, Linux: dircolors)
zinit ice atclone'"$(command -v gdircolors || command -v dircolors)" -b LS_COLORS > c.zsh' \
  atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# tmux configuration (oh-my-tmux)
zinit ice wait silent as"program" nocompile run-atpull \
  atinit'ln -s -f "$(pwd)/.tmux.conf" ~/.tmux.conf; cp -n .tmux.conf.local ~/.tmux.conf.local'
zinit light gpakosz/.tmux
fi

# ---- Tools (all guarded) --------------------------------------------------
(( $+commands[eza] )) && alias ls="eza"

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

if (( $+commands[starship] )); then
  export STARSHIP_CONFIG=~/.config/starship.toml
  eval "$(starship init zsh)"
else
  PS1="READY > "
fi

if (( $+commands[broot] )); then
  source <(broot --print-shell-function zsh)
fi

# NVM - lazy loaded to keep shell start fast
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME}/.nvm"
[[ -d $NVM_DIR ]] || NVM_DIR="$HOME/.nvm"
if [[ -s $NVM_DIR/nvm.sh ]]; then
  _nvm_lazy() {
    unset -f nvm node npm npx _nvm_lazy
    source "$NVM_DIR/nvm.sh"
  }
  for _cmd in nvm node npm npx; do
    eval "$_cmd() { _nvm_lazy; $_cmd \"\$@\"; }"
  done
  unset _cmd
fi

# CodeEditApp integration
[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" && -r /Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh ]] \
  && . /Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh

# Machine-local overrides (not tracked)
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
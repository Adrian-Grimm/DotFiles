# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt (non-printing sequences wrapped in \[ \])
PS1='\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\n$ '

# Flyline - enhanced Bash experience (needs bash >= 5)
# Install: source <(curl -sSfL https://github.com/HalFrgrd/flyline/releases/latest/download/install.sh)
if (( BASH_VERSINFO[0] >= 5 )); then
  case "$(uname -s)" in
    Darwin) _flyline_lib="$HOME/.local/lib/libflyline.dylib" ;;
    *)      _flyline_lib="$HOME/.local/lib/libflyline.so" ;;
  esac
  if enable flyline 2>/dev/null; then
    :
  elif [[ -f $_flyline_lib ]]; then
    enable -f "$_flyline_lib" flyline 2>/dev/null
  fi
  unset _flyline_lib

  # Flyline prompt options
  RPS1='\e[01;32m\t\e[0m'
  PS2='\e[2mline FLYLINE_PROMPT_LINE_NUMBER:\e[0m '
  PS1_FINAL='Ran at \D{%Y-%m-%d %H:%M:%S}> '
  PROMPT_RULER=$'\e[90m─\e[0m'
  PS1_FILL='-'
  RPS1_FINAL=''
  PS1_FILL_FINAL=''
  PROMPT_RULER_FINAL=''
fi

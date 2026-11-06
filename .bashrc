PS1='\e[01;32m\u@\h\e[00m:\e[01;34m\w\e[00m\n$ '
RPS1='\e[01;33m\t\n<\e[00m'
PROMPT_RULER=$'\e[90m─\e[0m'
PS1_FILL='-'
PS2='\e[2mline FLYLINE_PROMPT_LINE_NUMBER:\e[0m '
PS1_FINAL='Ran at \D{%Y-%m-%d %H:%M:%S}> '
RPS1_FINAL=''
PS1_FILL_FINAL=''
PROMPT_RULER_FINAL=''
# Right prompt showing 24-hour time in green
RPS1='\e[01;32m\t\e[0m'

# Flyline - enhanced Bash experience
# source <(curl -sSfL https://github.com/HalFrgrd/flyline/releases/latest/download/install.sh)
enable flyline 2>/dev/null || enable -f "~/.local/lib/libflyline.dylib" flyline

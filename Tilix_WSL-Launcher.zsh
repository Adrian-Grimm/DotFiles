#bin! zsh
Powershell.exe -Command 'start X410.exe /WM'

tmux new-session -s "Tilix" -n "Console" -d&
tmux send-keys -t Tilix "Display=:0 dbus-launch --exit-with-session tilix&" C-m

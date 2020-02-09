#bin! zsh
# This Starts X410 and Tilix in Windows with no visible Startup Console
Powershell.exe -Command 'start X410.exe /WM'

tmux new-session -s "Tilix" -n "Console" -d&

#Enable High-DPI Support:
# tmux send-keys -t Tilix "export QT_SCALE_FACTOR=2" C-m
# tmux send-keys -t Tilix "export GDK_SCALE=2" C-m

tmux send-keys -t Tilix "Display=:0 dbus-launch --exit-with-session tilix&" C-m

# Create a Link in Windows with:
#   C:\Windows\System32\wsl.exe -d WLinux -- tmux -c "zsh ~/Tilix_WSL-Launcher.zsh"

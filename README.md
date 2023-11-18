# Configs

## Multi monitor support for legion

1. Use `./.config/scripts/nvidia_toggle_xorg.sh` script to configure xorg
2. Restart xserver session (logout and login)
3. Use `Shift+Alt+Space` keybinding to open screen split options and use it or use `xrandr`

Note:

`nvidia_toggle_xorg.sh` has three modes.

1. `--nvidia` : Outputs screen to hdmi port only and not laptop/integrated screen
2. `--amd`: For laptop/integrated screen only
3. `--multi-monitor`: Uses both `amd` and `nvidia` cards to render screens

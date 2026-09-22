#!/usr/bin/env fish
function gnome_terminal_set_colors -a bg fg
    type -q gsettings; or return
    for id in (gsettings get org.gnome.Terminal.ProfilesList list | string match -ar "[a-f0-9-]{36}")
        set -l schema org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$id/
        gsettings set $schema use-theme-colors false
        gsettings set $schema background-color "$bg"
        gsettings set $schema foreground-color "$fg"
    end
end
status is-interactive; or gnome_terminal_set_colors $argv

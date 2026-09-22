#!/usr/bin/env fish
function light
    if test -d ~/.config/alacritty/themes
        set -q ALACRITTY_LIGHT_THEME; or set ALACRITTY_LIGHT_THEME github_light
        rm -f ~/.config/alacritty/current_theme.toml
        ln -s ~/.config/alacritty/themes/$ALACRITTY_LIGHT_THEME.toml ~/.config/alacritty/current_theme.toml
        touch ~/.config/alacritty/alacritty.toml
    end
    if string match -q "Darwin" -- (uname)
        # Set the system theme to light
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
        echo "System theme set to light mode."
    else if type -q gsettings
        # Set the GNOME/Pop!_OS system theme to light
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        gsettings set org.gnome.desktop.interface gtk-theme 'Pop' 2>/dev/null
        # Recolor GNOME Terminal profiles so open windows (and Claude Code) update immediately
        gnome_terminal_set_colors 'rgb(238,238,236)' 'rgb(46,52,54)'
        echo "System theme set to light mode."
    end
end
status is-interactive; or light $argv

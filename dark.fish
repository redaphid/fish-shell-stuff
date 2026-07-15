#!/usr/bin/env fish
function dark
    if test -d ~/.config/alacritty/themes
        set -q ALACRITTY_DARK_THEME; or set ALACRITTY_DARK_THEME github_dark_default
        rm -f ~/.config/alacritty/current_theme.toml
        ln -s ~/.config/alacritty/themes/$ALACRITTY_DARK_THEME.toml ~/.config/alacritty/current_theme.toml
        touch ~/.config/alacritty/alacritty.toml
    end
    if string match -q "Darwin" -- (uname)
        # Set the system theme to dark
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    else if type -q gsettings
        # Set the GNOME/Pop!_OS system theme to dark
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark' 2>/dev/null
        # Recolor GNOME Terminal profiles so open windows (and Claude Code) update immediately
        gnome_terminal_set_colors 'rgb(51,51,51)' 'rgb(242,242,242)'
    end
end
status is-interactive; or dark $argv

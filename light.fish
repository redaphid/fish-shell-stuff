#!/usr/bin/env fish
function light
    set -q ALACRITTY_LIGHT_THEME; or set ALACRITTY_LIGHT_THEME github_light
    rm ~/.config/alacritty/current_theme.toml
    ln -s ~/.config/alacritty/themes/$ALACRITTY_LIGHT_THEME.toml ~/.config/alacritty/current_theme.toml
    touch ~/.config/alacritty/alacritty.toml
    if string match -q "Darwin" -- (uname)
        # Set the system theme to light
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
        echo "System theme set to light mode."
    end
end
status is-interactive; or light $argv

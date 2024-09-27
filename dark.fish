#!/usr/bin/env fish
function dark
    set -q ALACRITTY_DARK_THEME; or set ALACRITTY_DARK_THEME github_dark_default
    rm ~/.config/alacritty/current_theme.toml
    ln -s ~/.config/alacritty/themes/$ALACRITTY_DARK_THEME.toml ~/.config/alacritty/current_theme.toml
    touch ~/.config/alacritty/alacritty.toml
    if string match -q "Darwin" -- (uname)
        # Set the system theme to dark
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    end
end
status is-interactive; or dark $argv

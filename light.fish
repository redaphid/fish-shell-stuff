#!/usr/bin/env fish
function light
    set -q ALACRITTY_LIGHT_THEME; or set ALACRITTY_LIGHT_THEME github_light
    rm ~/.config/alacritty/current_theme.toml
    ln -s ~/.config/alacritty/themes/$ALACRITTY_LIGHT_THEME.toml ~/.config/alacritty/current_theme.toml
    touch ~/.config/alacritty/alacritty.toml
end
status is-interactive; or light $argv

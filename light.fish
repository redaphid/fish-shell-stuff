#!/usr/bin/env fish
function light
    set -q ALACRITTY_LIGHT_THEME; or set ALACRITTY_LIGHT_THEME github_light_default
    rm ~/.config/alacritty/current_theme.yaml
    ln -s ~/.config/alacritty/themes/$ALACRITTY_LIGHT_THEME.yaml ~/.config/alacritty/current_theme.yaml
    touch ~/.config/alacritty/alacritty.yml
end
status is-interactive; or 'light'  $argv

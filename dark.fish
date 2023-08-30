#!/usr/bin/env fish
function dark
    set -q ALACRITTY_DARK_THEME; or set ALACRITTY_DARK_THEME github_dark_default
    rm ~/.config/alacritty/current_theme.yaml
    ln -s ~/.config/alacritty/themes/$ALACRITTY_DARK_THEME.yaml ~/.config/alacritty/current_theme.yaml
end
status is-interactive; or 'dark'  $argv

function dark
    set -q ALACRITTY_DARK_THEME; or set ALACRITTY_DARK_THEME github_light_default
    rm ~/.config/alacritty/current_theme.yaml
    echo ln -s ~/.config/alacritty/themes/$ALACRITTY_DARK_THEME.yaml ~/.config/alacritty/current-theme.yaml
end

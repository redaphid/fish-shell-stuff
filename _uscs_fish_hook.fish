function _uscs_fish_hook --on-event fish_prompt
    if not contains "$HOME/uscs/bin" $fish_user_paths                                                                                                                                            13:39:38
            set -Ua fish_user_paths $HOME/uscs/bin                            
    end    
    for f in (ls ~/profile.d/*.fish)
        . $f
    end
end
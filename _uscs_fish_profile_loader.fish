function _uscs_fish_profile_loader
    for f in (ls ~/profile.d/*.fish)
        source $f
    end
end

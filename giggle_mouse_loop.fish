function giggle_mouse_loop --argument interval
    set -q interval[1]; or set interval 5000
    set old_mouse_location (xdotool getmouselocation)
    while true
        set new_mouse_location (xdotool getmouselocation)
        test "$old_mouse_location" = "$new_mouse_location"; or continue
        echo "mouse was same. gotta giggle"
        set old_mouse_location $new_mouse_location
        giggle_mouse
        sleep $interval
    end
    
end

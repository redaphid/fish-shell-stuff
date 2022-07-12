function giggle_mouse_loop --argument interval
    set -q interval[1]; or set interval 5000
    set old_mouse_location (xdotool getmouselocation)
    while true
        set new_mouse_location (xdotool getmouselocation)
        test "$old_mouse_location" = "$new_mouse_location"; and continue
        echo "mouse location is different"
        sleep $interval
    end
    
end

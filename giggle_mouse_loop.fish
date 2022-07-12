function giggle_mouse_loop --argument interval
    set -q interval[1]; or set interval 5000
    set old_mouse_location (xdotool getmouselocation)
    while true
        sleep $interval
        set new_mouse_location (xdotool getmouselocation)
        echo "$old_mouse_location = $new_mouse_location"
        test "$old_mouse_location" = "$new_mouse_location"; or begin
            set old_mouse_location $new_mouse_location
            echo "mouse was not equal"
            continue
        end
        echo "mouse was same. gotta giggle"
        giggle_mouse
    end
    
end

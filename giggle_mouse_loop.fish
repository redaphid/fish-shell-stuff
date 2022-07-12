function giggle_mouse_loop --argument interval
    set -q interval[1]; or set interval 5000
    set old_mouse_location (xdotool getmouselocation)
    while true
        set new_mouse_location (xdotool getmouselocation)
        echo $old_mouse_location $new_mouse_location
        test "$old_mouse_location" = "$new_mouse_location"; and begin
            echo "mouse location is the same"
           set old_mouse_location $new_mouse_location
           continue
        end
        echo "mouse location is different"
        set old_mouse_location $new_mouse_location
        sleep $interval
    end
    
end

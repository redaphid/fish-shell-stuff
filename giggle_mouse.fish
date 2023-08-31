function giggle_mouse
   set pos_x (math --scale 0 (random)'/100')
   set pos_y (math --scale 0 (random)'/100')
   set windows (xdotool search --name ".*Slack.*\|")
   set -q windows[1]; or begin
       echo "Slack not detected"
       return 1
   end
   for w in $windows
   xdotool mousemove --window $w $pos_x $pos_y
   end
                                                                
end

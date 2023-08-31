#!/usr/bin/env fish
function toggle_window --argument window_id
 set -q window_id; or set $window_id $TOGGLE_WINDOW_ID
set -q window_id; or begin
echo "please specify the window id or set the environment variable TOGGLE_WINDOW_ID to the window you want to toggle"
return 1
end
test "$window_id" = (xdotool getwindowfocus); and begin
xdotool windowminimize $window_id
return
end
xdotool windowraise $window_id
xdotool windowfocus $window_id
end

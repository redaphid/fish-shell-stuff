#!/usr/bin/env fish
function watch_macropad
evtest /dev/input/event25 | while read line; echo $line | grep -q "EV_KEY"; or continue; echo "got an event: $line"; set parts (string split ' ' $line)[-3]; echo $parts;end
end

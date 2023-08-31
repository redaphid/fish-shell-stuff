#!/usr/bin/env fish
function macro_watcher
evtest /dev/input/event25 | while read line
echo $line | grep -q "EV_KEY"; or continue
echo $line | grep -q "time"; or continue
 set parts (string split ' ' $line);
 set state_raw $parts[-1]; 
 test "0" -eq "$state_raw"; and set state "up"
 test "1" -eq "$state_raw"; and set state "down"
 test "2" -eq "$state_raw"; and set state "hold"
 set key (string trim --chars="()," $parts[-3])
 echo "key: $key state: $state"
end
end
status is-interactive; or macro_watcher $argv

#!/usr/bin/env fish
function monitor-get-control-device
 echo  (ddccontrol -p 2>/dev/null| grep "Device" | string split 'dev:')[-1]; 
end

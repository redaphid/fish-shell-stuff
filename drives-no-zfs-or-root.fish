#!/usr/bin/env fish
function drives-no-zfs-or-root --description returns\ a\ list\ of\ disk\ partitions\ \(by-id\)\ that\ don\'t\ include\ zfs\ drives\ or\ the\ root\ device
ls -l /dev/disk/by-id | grep part | grep -E (drives-no-zfs | string join '|') | grep -v (drives-root | string trim --chars=1234567890 ) | awk '{print $9}'
end
status is-interactive; or 'drives-no-zfs-or-root'  $argv

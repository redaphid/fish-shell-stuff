#!/usr/bin/env fish
function drives-no-zfs
ls /dev/disk/by-id | grep -Ev (get-zfs-drives | string join "|")
end
status is-interactive; or 'drives-no-zfs'  $argv

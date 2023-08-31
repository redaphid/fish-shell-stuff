#!/usr/bin/env fish
function get-zfs-drives
zpool status | grep ata | awk '{print $1}' | grep -v errors
end
status is-interactive; or get-zfs-drives $argv

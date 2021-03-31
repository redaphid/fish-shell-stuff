function get-zfs-drives
zpool status | grep ata | awk '{print $1}' | grep -v errors
end

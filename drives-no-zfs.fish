function drives-no-zfs
ls /dev/disk/by-id | grep -Ev (get-zfs-drives | string join "|")
end

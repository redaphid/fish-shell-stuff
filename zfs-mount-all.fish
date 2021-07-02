# Defined interactively
function zfs-mount-all
zfs list -o name -r f18/drives | xargs -l zfs mount
end

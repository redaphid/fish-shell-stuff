function find-large-files --argument dir
    set -q dir; or set dir "."
    ncdu --exclude /big --exclude /tmp --exclude /proc --exclude /var/lib/docker --exclude /mnt --exclude / $dir
end

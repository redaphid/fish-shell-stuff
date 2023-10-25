#!/usr/bin/env fish
function find-large-files --argument dir
    set -q dir; or set dir "."
    ncdu --exclude /big --exclude /tmp --exclude /proc --exclude /var/lib/docker --exclude /mnt --exclude / $dir
end
status is-interactive; or find-large-files $argv

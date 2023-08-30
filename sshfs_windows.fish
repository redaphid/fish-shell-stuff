#!/usr/bin/env fish
function sshfs_windows
    sshfs -C -o CompressionLevel=9,allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,cache_timeout=3600 $argv
end
status is-interactive; or 'sshfs_windows'  $argv

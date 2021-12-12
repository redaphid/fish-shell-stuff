function sshfs_windows
    sshfs -o allow_other,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,cache_timeout=3600 $argv
end

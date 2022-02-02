function find-large-files
ncdu --exclude "/big" --exclude "/tmp" --exclude "/proc" --exclude "/var/lib/docker" --exclude "/mnt" /
end

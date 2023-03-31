function find-large-files -a dir
set -q dir; or set dir "."
ncdu --exclude "/big" --exclude "/tmp" --exclude "/proc" --exclude "/var/lib/docker" --exclude "/mnt" / $dir
end

#!/usr/bin/env fish
function docker-remove-all-volumes
docker-compose down;
docker rm -f (docker ps -a -q);
docker volume rm (docker volume ls -q);
end
status is-interactive; or docker-remove-all-volumes $argv

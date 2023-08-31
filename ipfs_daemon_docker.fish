#!/usr/bin/env fish
function ipfs_daemon_docker
docker rm ipfs_host; docker run -it --name ipfs_host -v $ipfs_staging:/export -v $ipfs_data:/data/ipfs -p 4001:4001 -p 4001:4001/udp -p 127.0.0.1:8080:8080 -p 127.0.0.1:5001:5001 ipfs/go-ipfs:latest
end
status is-interactive; or ipfs_daemon_docker $argv

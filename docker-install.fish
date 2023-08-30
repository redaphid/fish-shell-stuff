#!/usr/bin/env fish
function docker-install
 sudo apt-get remove docker docker-engine docker.io containerd runc
 sudo apt update 
 sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo  mkdir -p /etc/apt/keyrings

 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 sudo apt update 
 sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
end
status is-interactive; or 'docker-install'  $argv

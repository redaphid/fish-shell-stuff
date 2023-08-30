#!/usr/bin/env fish
function redaphid_setup_fish
    #omf
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    #fisher
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    #pastel
    curl "https://github.com/sharkdp/pastel/releases/download/v0.8.1/pastel_0.8.1_amd64.deb" > /tmp/pastel.deb;and sudo apt install -y /tmp/pastel.deb; and rm /tmp/pastel.deb
end
status is-interactive; or 'redaphid_setup_fish'  $argv

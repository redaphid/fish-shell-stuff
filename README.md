# Functions for @redaphid's fish shell

## Installation instructions:
1. Get fish from somewhere (varies by os/distro)
1. clone this repo
1. add this repo to Fish's function search dir
    `set -aU fish_function_path ~/Projects/fish-shell-stuff`
1. setup nvm
    1. setup fisher
        `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`
    1. install nvm
        `fisher install jorgebucaran/nvm.fish`
1. setup nvm use
    1. install version of node
        `nvm install latest`
    1. edit `cat ~/.config/fish/config.fish` and paste `nvm_use` in there somewhere


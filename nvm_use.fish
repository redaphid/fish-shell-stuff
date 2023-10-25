#!/usr/bin/env fish
function nvm_use --on-variable PWD
        ls -aq1 | grep .nvmrc
        and fnm use (cat .nvmrc) --silent-if-unchanged
end
status is-interactive; or nvm_use $argv

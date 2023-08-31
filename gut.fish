#!/usr/bin/env fish
function gut --wraps=git
    git $argv
end
status is-interactive; or gut $argv

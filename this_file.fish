#!/usr/bin/env fish
function this_file
    echo (realpath (status current-filename))
end
status is-interactive; or this_file $argv

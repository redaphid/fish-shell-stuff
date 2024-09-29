#!/usr/bin/env fish
function this_dir
echo (realpath (dirname (status current-filename)))
end
status is-interactive; or this_dir $argv

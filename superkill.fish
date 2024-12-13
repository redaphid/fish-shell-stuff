#!/usr/bin/env fish
function superkill
 ps ax | grep -i $argv[1] | awk '{print $1}' | xargs kill; 
end
status is-interactive; or superkill $argv

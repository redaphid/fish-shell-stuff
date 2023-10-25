#!/usr/bin/env fish
function network-names
 ip -br link show | grep '^e*' | awk '{print $1}' | grep -o '^e.*'; 
end
status is-interactive; or network-names $argv

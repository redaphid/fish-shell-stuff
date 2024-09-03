#!/usr/bin/env fish
function ptouch --wraps=touch
echo mkdir -p (dirname $argv[1])
echo touch $argv
end
status is-interactive; or ptouch $argv

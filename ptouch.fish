#!/usr/bin/env fish
function ptouch --wraps=touch
mkdir -p (dirname $argv[1])
touch $argv
end
status is-interactive; or ptouch $argv

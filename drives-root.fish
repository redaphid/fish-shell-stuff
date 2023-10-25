#!/usr/bin/env fish
function drives-root
mount | sed -n 's|^/dev/\(.*\) on / .*|\1|p'
end
status is-interactive; or drives-root $argv

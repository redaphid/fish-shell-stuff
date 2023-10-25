#!/usr/bin/env fish
function whatsmyip
curl http://ifconfig.me
end
status is-interactive; or whatsmyip $argv

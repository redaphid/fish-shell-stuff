#!/usr/bin/env fish
function force-ethernet-to-1000
 sudo /usr/sbin/ethtool -s (network-names) speed 1000 duplex full autoneg off
end
status is-interactive; or force-ethernet-to-1000 $argv

#!/usr/bin/env fish
function if-internet-is-too-slow-restart
    set -l minimum_speed 200
    set -l raw_internet_speed (speedtest --json | jq '.download')
    set -l internet_speed (math $raw_internet_speed '/' 1000000)
    echo $internet_speed $minimum_speed $raw_internet_speed
    test $internet_speed -gt $minimum_speed; or begin
      echo "I'm gonna do it"
      sudo /usr/sbin/ethtool -s (network-names) speed 1000 duplex full autoneg off

    end
    touch /tmp/too-slow
end
status is-interactive; or if-internet-is-too-slow-restart

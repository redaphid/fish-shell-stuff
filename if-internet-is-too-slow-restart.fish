function if-internet-is-too-slow-restart
    set -l minimum_speed 200
    set -l raw_internet_speed (cat tmp/speedtest.json | jq '.download')
    set -l internet_speed (math $raw_internet_speed '/' 1000000)
    echo $internet_speed $minimum_speed $raw_internet_speed
    test $internet_speed -gt $minimum_speed; or begin
      echo "too slow"
    end
end

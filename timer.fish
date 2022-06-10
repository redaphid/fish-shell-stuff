function timer --argument time msg
sleep $time
set -q msg[1]; or set msg "TIMER"
notify-send $msg; or echo "couldn't send $msg"
speaker-test --rate 35000 --nperiods 2 --period 1
end

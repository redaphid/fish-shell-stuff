function monitor-switch-input --argument monitor
    set -q monitor[1]; or set -l monitor $MONITOR_INPUT
    while true
        sleep 3
	echo "monitor before: $monitor"
	set -q monitor[1]; or set -l monitor (monitor-get-control-device)
	echo "monitor after: $monitor"
        has_das; and begin
            echo "has das"
            ssh mortal.local ddccontrol -r 0x60 dev:$monitor 2>/dev/null | grep 15; and continue
            ssh mortal.local ddccontrol -r 0x60 -w 15 dev:$monitor
            continue
        end
        ssh mumra.local has_das; and begin
            echo "mumra has_das"
            ssh mortal.local ddccontrol -r 0x60 dev:$monitor 2>/dev/null | grep 17; and continue
            ssh mortal.local ddccontrol -r 0x60 -w 17 dev:$monitor
            continue
        end
        ssh mortal.local ddccontrol -r 0x60 dev:$monitor 2>/dev/null | grep 18; and continue
        ssh mortal.local ddccontrol -r 0x60 -w 18 dev:$monitor
	continue
    end

end

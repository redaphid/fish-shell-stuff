function switch_monitor_input
    set -q MONITOR_INPUT[1]; or begin
        echo "please set MONITOR_INPUT to the i2c input code you want to switch to (e.g. 15,17)"
        return
    end
    while true
        sleep 3

        has_das; and begin
            echo "has das"
            ssh mortal.local ddccontrol -r 0x60 dev:$MONITOR_INPUT 2>/dev/null | grep $MONITOR_INPUT; and continue
            ssh mortal.local ddccontrol -r 0x60 -w 15 dev:$MONITOR_INPUT
            continue
        end
        ssh mumra.local has_das; and begin
            echo "mumra has_das"
            ssh mortal.local ddccontrol -r 0x60 dev:$MONITOR_INPUT 2>/dev/null | grep 17; and continue
            ssh mortal.local ddccontrol -r 0x60 -w 17 dev:$MONITOR_INPUT
            continue
        end
        ssh mortal.local ddccontrol -r 0x60 dev:$MONITOR_INPUT 2>/dev/null | grep 18; and continue
        ssh mortal.local ddccontrol -r 0x60 -w 18 dev:$MONITOR_INPUT

    end

end

function switch_monitor_input
                          while true
                              sleep 10
                              set has_das (lsusb | grep "Das Keyboard")
                              set -q has_das[1]; or begin
          echo "no das"
                                  continue
                              end
      ssh mortal.local ddccontrol -r 0x60 dev:/dev/i2c-9 | grep "17"; and continue
      ssh mortal.local ddccontrol -r 0x60 -w 17 dev:/dev/i2c-9
      echo "switching input"
                          end
                      
end

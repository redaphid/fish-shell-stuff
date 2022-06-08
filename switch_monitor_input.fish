function switch_monitor_input
                          set -q MONITOR_INPUT[1]; or begin
                              echo "please set MONITOR_INPUT to the i2c input code you want to switch to (e.g. 15,17)"
                              return
                          end
                          while true
                              sleep 3
                              set has_das (lsusb | grep "Das Keyboard")
                              set -q has_das[1]; or begin
                                  echo "no das"
                                  continue
                              end
                              ssh mortal.local ddccontrol -r 0x60 dev:/dev/i2c-9 | grep $MONITOR_INPUT; and continue
                              ssh mortal.local ddccontrol -r 0x60 -w $MONITOR_INPUT dev:/dev/i2c-9
                              echo "switching input"
                          end

                      end


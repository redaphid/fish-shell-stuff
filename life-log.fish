#!/usr/bin/env fish
function life-log --argument value message
    set cmd  "http -b $LIFE_LOG_URL authorization:$LIFE_LOG_TOKEN test:$LIFE_LOG_TEST"
    # if we have a value, we will log it
    if test -n "$value"
        set logging true
        set cmd "$cmd value:=$value"
        if test -n "$message"
            set cmd "$cmd message=\"$message\""
        end
    end
    # if either value or message is set, we will log the gps
    if test -n "$logging"
        set cmd "$cmd gps:=(gps)"
    end
    eval $cmd
end
status is-interactive; or life-log $argv

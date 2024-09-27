#!/usr/bin/env fish
function time_diff --description 'Calculate difference between two ISO 8601 timestamps using gdate'
    if test (count $argv) -ne 2
        echo "Usage: time_diff <start_iso8601> <end_iso8601>"
        return 1
    end

    set start_time (gdate -d $argv[1] +%s)
    set end_time (gdate -d $argv[2] +%s)

    if test $status -ne 0
        echo "Invalid ISO 8601 timestamp"
        return 1
    end

    set time_diff (math $end_time - $start_time)

    echo "$time_diff seconds"
    echo (math $time_diff / 60) "minutes"
    echo (math $time_diff / 3600) "hours"
    echo (math $time_diff / 86400) "days"
end
status is-interactive; or time_diff $argv

#!/usr/bin/env fish
function ros-functions-prune --description remove\ functions\ that\ don\'t\ exist\ in\ this\ shell\ from\ the\ ROS_SAVED_FUNCTIONS\ list
    set -l VERIFIED_FUNCTIONS ''
    for f in $ROS_SAVED_FUNCTIONS
        functions -q $f; or continue
        set -a VERIFIED_FUNCTIONS $f

    end

    set ROS_SAVED_FUNCTIONS (string split ' ' $VERIFIED_FUNCTIONS[2..] | sort | uniq)
end
status is-interactive; or ros-functions-prune $argv

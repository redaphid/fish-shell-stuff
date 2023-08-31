#!/usr/bin/env fish
function ros-get-latest
    set -q save_dir[1]; or set save_dir $ROS_FUNCTION_LOCATION
    set -q save_dir[1]; or begin
        echo "I need to know where to save stuff to. try calling this with `save_dir=<directory with the functions> ros-save <functions...>"
        echo "or setting ROS_FUNCTION_LOCATION as en env var for your system"
        return 1
    end
    pushd $ROS_FUNCTION_LOCATION
    git pull
    popd
end
status is-interactive; or ros-get-latest $argv

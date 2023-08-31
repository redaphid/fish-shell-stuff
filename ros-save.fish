function ros-save
    set -q save_dir[1]; or set save_dir $ROS_FUNCTION_LOCATION
    set -q save_dir[1]; or begin
        echo "I need to know where to save stuff to. try calling this with `save_dir=<directory with the functions> ros-save <functions...>"
        echo "or setting ROS_FUNCTION_LOCATION as en env var for your system"
        return 1
    end
    set fns $argv
    set -q ROS_SAVE_ALL_FUNCTIONS[1]; and begin
        set fns -a (string split ' ' $ROS_SAVED_FUNCTIONS)
    end

    set -q fns[1]; or begin
        echo "pls specify the functions you wish to save. e.g. `ros-save hello_world`"
        echo "or specify ROS_SAVE_ALL_FUNCTIONS in the environment somewhere"
        return 1
    end

    pushd $save_dir

    for f in $fns
        funcsave --directory $save_dir "$f"
        git add "$f.fish"
        ros-make-executable "$f.fish"
        set -Ua ROS_SAVED_FUNCTIONS $f
    end
    git commit -m "functions: $fns"
    git push
    set -U ROS_SAVED_FUNCTIONS (string collect $ROS_SAVED_FUNCTIONS | sort | uniq)
    popd
end

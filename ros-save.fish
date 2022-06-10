function ros-save
    echo $argv
    set -q save_dir[1]; or set save_dir $ROS_FUNCTION_LOCATION
    set -q save_dir[1]; or begin
        echo "I need to know where to save stuff to. try calling this with `save_dir=<directory with the functions> ros-save <functions...>"
        echo "or setting ROS_FUNCTION_LOCATION as en env var for your system"
        return 1
    end
    set -q argv[1]; or begin
        echo "pls specify the functions you wish to save. e.g. `ros-save hello_world`"
        return 1
    end
    set -q prefix[1]; or set prefix ''

    pushd $save_dir

    for f in $argv
        funcsave --directory $save_dir $f
        git add "$f.fish"
    end
    git commit -m "functions: $argv"
    git push
    popd
end

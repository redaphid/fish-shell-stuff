function ros-functions-make-executable --argument directory
    set -q directory[1]; or set -l directory $ROS_FUNCTION_LOCATION
    set -q directory[1]; or begin
        echo "I'm not sure what directory to check the functions in"
        return 1
    end

    for f in (find $ROS_FUNCTION_LOCATION | grep '.fish$')
        test -x $f; or continue
        set body (cat $f)
        string match -q "#!/usr/bin/env fish" $body[1]; or begin
            echo "$f is wrong." $body[1]
        end
    end
end

function ros-functions-make-executable --argument directory
    set -q directory[1]; or set -l directory $ROS_FUNCTION_LOCATION
    set -q directory[1]; or begin
        echo "I'm not sure what directory to check the functions in"
        return 1
    end
    set -l shebang "#!/usr/bin/env fish"
    for f in (find $ROS_FUNCTION_LOCATION | grep '.fish$')
        test -x $f; or continue
        echo (basename $f)
        set -l fn_name (string replace --regex '\.fish$' '' (basename $f))
        echo $fn_name; and return
        set -l body (cat $f)
        string match -q $shebang $body[1]; or begin
            echo "$f has the wrong shebang" $body[1]
            set -p body $shebang
            for l in $body
                echo $l
            end
        end
    end
end

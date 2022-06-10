function ros-functions-make-executable --argument directory
    set -q directory[1]; or set -l directory $ROS_FUNCTION_LOCATION
    set -q directory[1]; or begin
        echo "I'm not sure what directory to check the functions in"
        return 1
    end
    set -l shebang "#!/usr/bin/env fish"
    for f in (find $ROS_FUNCTION_LOCATION | grep '.fish$')
        test -x $f; or continue
        set -l fn_name (string replace --regex '\.fish$' '' (basename $f))
        set -l body (cat $f)
        string match -q $shebang $body[1]; or begin
            echo "$f has the wrong shebang" $body[1]
            set -p body $shebang
        end
        set good_footer "status is-interactive; or $fn_name \$argv"
        set fn_footer $body[-1]
        string match -q $good_footer $fn_footer; or begin
            string match -rq "end|return" $fn_footer; or begin
                echo "Not sure what the end of this function is, but I don't want to risk anything. Aborting."
            end
            echo "we can work with $fn_footer"
            set -a body $good_footer

        end
    end
end

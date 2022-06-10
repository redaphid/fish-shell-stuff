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
        echo "$fn_name is executable!"
        test $fn_name[1] = _; and begin
            echo "ignoring $fn_name as it begins with an _"
            continue
        end

        set -l body (cat $f)

        string match -q $shebang $body[1]; or begin
            echo "adding shebang to $fn_name"
            set -p body $shebang
        end
        #string match --entire --regex "^[\s]+" 
        while string match --entire --regex "^[\s]+" $body[-1]
            echo "last line was whitespace ($body[-1])"
            set body $body[..-1]
            echo $body
        end
        return
        set good_footer "status is-interactive; or $fn_name \$argv"
        set fn_footer $body[-1]
        string match -q -r '^\s+$' $fn_footer; and begin
            echo "$fn_footer is empty"
        end

        string match -q $good_footer $fn_footer; or begin
            string match -rq "end|return" $fn_footer; or begin
                echo "Not sure what the end of this function is, but I don't want to risk anything. Aborting."
            end
            echo "I'm gonna add a footer to $fn_name"
            set -a body $good_footer
        end
        printf "\nAight. This is what this new fn would look like:\n"
        for l in $body
            printf '\t'$l'\n'
        end
    end
end

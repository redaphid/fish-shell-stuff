#!/usr/bin/env fish
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

        while string match --entire --regex "^[\s]+" $body[-1]; or test $body[-1] = ''
            echo "last line was whitespace ($body[-1])"
            set body $body[..-2]
        end

        set good_footer "status is-interactive; or $fn_name \$argv"
        set good_footer_regex "^status is-interactive; .*\$"
        set fn_footer $body[-1]

        string match -q --regex $good_footer_regex $fn_footer; or begin
            string match --regex "return|end" $fn_footer; or begin
                echo "aborting due to weird footer: $fn_footer"
                continue
            end
            set -a body $good_footer
        end

        printf "\nAight. This is what this new fn would look like:\n\n"
        echo $body[1]
        for l in $body[2..]
            printf $l'\n'
        end
        read --prompt-str "make $f executable? (y/n) " --line answer
        test $answer[1] = y; or continue
	truncate --size 0 $f
        for l in $body
            echo $l >> $f
        end
    end
end
status is-interactive; or 'ros-functions-make-executable'  $argv

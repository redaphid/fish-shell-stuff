#!/usr/bin/env fish
function ros-make-executable
    set file_name $argv[1]

    # Extract the file name without the .fish prefix
    set base_name (string replace -ra '\.fish$' '' $file_name)

    # Read the first line of the file
    set first_line (head -n 1 $file_name)

    # Read the last line of the file
    set last_line (tail -n 1 $file_name)

    # Check if the first line is missing, add it
    if not contains -- "$first_line" "#!/usr/bin/env fish"
        echo "#!/usr/bin/env fish" >$file_name.tmp
        cat $file_name >>$file_name.tmp
        mv $file_name.tmp $file_name
        echo "Added shebang to '$file_name'."
    end

    # Check if the last line is missing, add it
    set expected_last_line "status is-interactive; or $base_name \$argv"
    if not contains -- "$last_line" "$expected_last_line"
        echo "$expected_last_line" >>$file_name
        echo "Added last line to '$file_name'."
    end

    # Make the file executable
    chmod +x $file_name
    echo "Made '$file_name' executable."
end
status is-interactive; or ros-make-executable $argv

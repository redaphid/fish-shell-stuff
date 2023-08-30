#!/usr/bin/env fish

# Iterate over all .fish files in the current directory
for file in *.fish
    if [ -f $file ]
        # Extract the file name without the .fish prefix
        set file_name (string replace -r '\.fish$' '' $file)
        
        # Read the first line of the file
        set first_line (head -n 1 $file)
        
        # Read the last line of the file
        set last_line (tail -n 1 $file)
        
        # Check if the first line is missing, add it
        if not contains -- "$first_line" "#!/usr/bin/env fish"
            echo "#!/usr/bin/env fish" > $file.tmp
            cat $file >> $file.tmp
            mv $file.tmp $file
            echo "Added shebang to '$file'."
        end
        
        # Check if the last line is missing, add it
        set expected_last_line "status is-interactive; or '$file_name'  \$argv"
        if not contains -- "$last_line" "$expected_last_line"
            echo "$expected_last_line" >> $file
            echo "Added last line to '$file'."
        end
        
        # Make the file executable
        chmod +x $file
        echo "Made '$file' executable."
    end
end
status is-interactive; or 'ros-make-executables'  $argv

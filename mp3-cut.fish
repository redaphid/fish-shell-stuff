#!/usr/bin/env fish
function mp3-cut
    # Parse the input arguments
    set -l input_file
    set -l output_file
    set -l start_time
    set -l end_time

    argparse 'i/o/' -- $argv | while read -l key value
        switch $key
            case '-i'
                set input_file $value
            case '-o'
                set output_file $value
            case '--'
                break
        end
    end

    # Check if all required parameters are provided
    if not set -q input_file; or not set -q output_file; or test (count $argv) -lt 2
        echo "Usage: mp3-cut -i <input_file> -o <output_file> <start_time> <end_time>"
        return 1
    end

    # Ensure start and end times are passed
    if not set -q argv[1]; or not set -q argv[2]
        echo "Start time and end time are required."
        return 1
    end

    set start_time $argv[1]
    set end_time $argv[2]

    # Run ffmpeg command
    ffmpeg -i $input_file -ss $start_time -to $end_time -c copy $output_file

    if test $status -eq 0
        echo "MP3 cut successfully: $output_file"
    else
        echo "Failed to cut MP3 file."
    end
end
status is-interactive; or mp3-cut $argv

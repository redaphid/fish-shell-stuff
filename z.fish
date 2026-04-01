function z --wraps=zellij --description 'Zellij wrapper that records sessions with asciinema'
    set -l recordings_dir ~/Recordings

    # Handle subcommands
    switch "$argv[1]"
        case trim
            __z_trim $recordings_dir $argv[2..]
            return $status
        case ''
            # no args, fall through to zellij
    end

    # Determine session name from args
    set -l session_name ""
    set -l i 1
    while test $i -le (count $argv)
        switch $argv[$i]
            case -s --session
                set i (math $i + 1)
                if test $i -le (count $argv)
                    set session_name $argv[$i]
                end
            case attach a
                set -l j (math $i + 1)
                while test $j -le (count $argv)
                    if not string match -q -- '-*' $argv[$j]
                        set session_name $argv[$j]
                        break
                    end
                    set j (math $j + 1)
                end
        end
        set i (math $i + 1)
    end

    if test -z "$session_name"
        set -l sessions (command zellij list-sessions 2>/dev/null | string replace -r '\s.*' '')
        if test (count $sessions) -eq 1
            set session_name $sessions[1]
        else
            set session_name (date +%Y%m%d-%H%M%S)
        end
    end

    set -l safe_name (string replace -a '/' '-' "$session_name")
    mkdir -p $recordings_dir
    set -l rec_file "$recordings_dir/$safe_name.cast"

    if not command -q asciinema
        echo "Error: asciinema not found. Install with: brew install asciinema" >&2
        return 1
    end

    echo "Recording to $rec_file"
    asciinema rec -f asciicast-v3 --command "zellij $argv" --title "zellij: $session_name" $rec_file
end

function __z_trim --description 'Trim a recording non-destructively using cast-trim'
    set -l recordings_dir $argv[1]
    set -l rest $argv[2..]

    if not command -q cast-trim
        echo "Error: cast-trim not found. Build and install from ~/Projects/cast-trim:" >&2
        echo "  cargo install --path ~/Projects/cast-trim" >&2
        return 1
    end

    # Parse: z trim <session> [--start N] [--duration N] [--output FILE]
    set -l session_name ""
    set -l start_time ""
    set -l duration ""
    set -l output ""

    set -l i 1
    while test $i -le (count $rest)
        switch $rest[$i]
            case --start
                set i (math $i + 1)
                set start_time $rest[$i]
            case --duration
                set i (math $i + 1)
                set duration $rest[$i]
            case --output -o
                set i (math $i + 1)
                set output $rest[$i]
            case '--*'
                echo "Unknown flag: $rest[$i]" >&2
                __z_trim_usage
                return 1
            case '*'
                if test -z "$session_name"
                    set session_name $rest[$i]
                else
                    echo "Unexpected argument: $rest[$i]" >&2
                    __z_trim_usage
                    return 1
                end
        end
        set i (math $i + 1)
    end

    if test -z "$session_name"
        echo "Available recordings:"
        for f in $recordings_dir/*.cast
            if test -f "$f"
                echo "  "(basename "$f" .cast)
            end
        end
        echo ""
        __z_trim_usage
        return 1
    end

    set -l safe_name (string replace -a '/' '-' "$session_name")
    set -l input_file "$recordings_dir/$safe_name.cast"

    if not test -f "$input_file"
        echo "Error: no recording found at $input_file" >&2
        return 1
    end

    # Default output: <session>-trimmed.cast in the same dir
    if test -z "$output"
        set output "$recordings_dir/$safe_name-trimmed.cast"
    end

    # Build cast-trim args
    set -l trim_args $input_file $output
    if test -n "$start_time"
        set -a trim_args --start $start_time
    end
    if test -n "$duration"
        set -a trim_args --duration $duration
    end

    cast-trim $trim_args

    if test $status -eq 0
        echo "Output: $output"
        echo "Play with: asciinema play $output"
    end
end

function __z_trim_usage
    echo "Usage: z trim <session> [--start SECONDS] [--duration SECONDS] [--output FILE]"
    echo ""
    echo "Non-destructive trim with VT state reconstruction."
    echo "The original recording is never modified."
    echo ""
    echo "Options:"
    echo "  --start N      Start time in seconds (default: 0)"
    echo "  --duration N   Duration in seconds (default: rest of recording)"
    echo "  --output FILE  Output file (default: <session>-trimmed.cast)"
end

status is-interactive; or z $argv

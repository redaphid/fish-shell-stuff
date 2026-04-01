function roll_die --description 'Roll an N‑sided die'
    # ensure a side‑count was provided
    set -q argv[1]; or begin
        echo "Usage: roll_die <sides>" >&2
        return 1
    end

    random 1 $argv[1]   # inclusive range 1‑N
end

function .env-to.envrc --argument directory
    set -q directory[1]; or set directory $PWD
    for l in (cat $directory/.env)
        string match -q '*=*' $l; and echo "$l has an equals sign"
    end
end

function .env-to.envrc --argument directory
    set -q directory[1]; or set directory $PWD
    test -f $directory/.envrc; and begin
        echo "$directory/.envrc exists. Cowardly refusing to do anything"
        return
    end
    for l in (cat $directory/.env)
        string match -q '*=*' $l; or continue
        set -a envrc "export $l"
    end
end

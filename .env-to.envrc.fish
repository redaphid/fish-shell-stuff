function .env-to.envrc --description 'reads a .env file from <directory>, and outputs a compatible .envrc' --argument directory
    set -q directory[1]; or set directory $PWD
    test -f $directory/.envrc; and begin
        echo "$directory/.envrc exists. Cowardly refusing to do anything"
        return
    end
    for l in (cat $directory/.env)
        string match -q '*=*' $l; or continue
        echo "export $l" >>$directory/.envrc
    end
end

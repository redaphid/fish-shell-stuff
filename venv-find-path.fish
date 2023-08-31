#!/usr/bin/env fish
function venv-find-path --description 'Find the path to the venv in the current directory or any of its parents' --argument path
    set -q path[1]; or begin
        set path $PWD
    end
    set path (realpath $path)
    if test -d "$path/venv"
        echo "$path/venv"
        return 0
    end
    if test "$path" = /
        return 1
    end
    set path (dirname $path)
    venv-find-path $path
    return 1
end

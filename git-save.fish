#!/usr/bin/env fish
function git-save --description Adds\ all\ files\ in\ my\ notes\ project\ and\ pushes,\ without\ interrupting\ my\ workflow\ by\ cd\'ing\ and\ other\ steps --argument project message
    set -q project[1]; or begin
        echo "a project must be specified"
        return -1
    end
    set -q message[1]; or set message "autosave"
    pushd $project
    git pull; or begin
        echo "something bad happened while pulling"
        popd
        return -1
    end
    git add .
    git commit -am $message
    git push
    popd
end
status is-interactive; or git-save $argv

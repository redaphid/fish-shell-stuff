function save-notes --description Adds\ all\ files\ in\ my\ notes\ project\ and\ pushes,\ without\ interrupting\ my\ workflow\ by\ cd\'ing\ and\ other\ steps --argument message
    pushd ~/Projects/notes
    set -q message[1]; or set message "autosave"
    git add .
    git commit -am $message
    git push
    popd
end

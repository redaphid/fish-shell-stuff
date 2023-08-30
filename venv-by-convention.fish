#!/usr/bin/env fish
function venv-by-convention --on-variable PWD --argument path
    set -q path[1]; or set path $PWD
    set -l venv_path (venv-find-path $PWD)
    if test -n "$venv_path"
        source $venv_path/bin/activate.fish
    else
        #if deactivate is not a function, then we are not in a venv
        type deactivate | grep -q "deactivate is a function with definition"; and source (deactivate)
    end
    return 0
end
status is-interactive; or 'venv-by-convention'  $argv

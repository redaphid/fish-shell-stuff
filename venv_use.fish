#!/usr/bin/env fish
function venv_use --on-variable PWD
        if test -d .venv/
            source .venv/bin/activate.fish            
        end
end
status is-interactive; or venv_use $argv

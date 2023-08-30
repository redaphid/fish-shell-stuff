#!/usr/bin/env fish
function fish_custom_prompt
    echo "hi"
    hostname_color_text; echo (whoami)@(hostname)
end
status is-interactive; or 'fish_custom_prompt'  $argv

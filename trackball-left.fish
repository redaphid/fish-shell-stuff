#!/usr/bin/env fish
function trackball-left
~/tools/kensington-expert-trackball-linux-config/Kensington_Expert_Setup.sh
end
status is-interactive; or trackball-left $argv

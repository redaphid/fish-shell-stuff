#!/usr/bin/env fish
function mac_dark
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
end
status is-interactive; or 'mac_dark'  $argv

#!/usr/bin/env fish
function hostname_color
 hostname | md5sum | string sub -s 1 -l 6
end
status is-interactive; or 'hostname_color'  $argv

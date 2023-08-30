#!/usr/bin/env fish
function groups-get
 getent group | cut -d: -f1;
end
status is-interactive; or 'groups-get'  $argv

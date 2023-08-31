#!/usr/bin/env fish
function ros-get-functions --argument quiet
 for f in (functions)
echo (functions -D $f) | grep -q 'redaphid'; or continue
set fn_header (echo (functions $f)[2] | string replace -r '^function ' '')
set -q quiet[1]; and begin
set fn_header (string split ' ' $fn_header)[1]
end
echo $fn_header
end
end

#!/usr/bin/env fish
function filename-sanitizer-dir
 for i in (ls -1); mv "./$i" (filename-sanitizer $i); end;
end
status is-interactive; or 'filename-sanitizer-dir'  $argv

#!/usr/bin/env fish
function fs-get-from-file --argument FILE
 string escape --style=var (echo (df $FILE)[2] | string split ' ')[1]; 
end
status is-interactive; or fs-get-from-file $argv

#!/usr/bin/env fish
function dls
   echo $_dls_new_functions
end
status is-interactive; or dls $argv

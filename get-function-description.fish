#!/usr/bin/env fish
function get-function-description --description 'gets the description of <function> in the hackyist way imaginable' --argument func
    echo (string unescape (functions -D  --verbose $func)[5])
end
status is-interactive; or get-function-description $argv
